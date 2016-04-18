import java.util.concurrent.locks {
	ReentrantLock
}
import java.util.concurrent.atomic {
	AtomicLong,
	AtomicBoolean
}


"This is helper class which implements multiservicing strategy in order to reach scalability:  
 * When load level is high new track is created and new service with given [[address]] is registered.
   So, a number services with the same address are registered simultaneously.  
 * When load level is low blocks (see [[JuncService.blocked]]) some services
   and removes unused ones together with tracks they were registered on.  
 
 Usage:  
 1. Extends and implement [[ServiceHandler]] which is used to handle service callbacks
    and instantiated for each registered service.  
 2. Instantiate and call [[registerService]] in order to register first service.  
 "
see( `interface JuncService` )
tagged( "communication" )
by( "Lis" )
shared abstract class MultiService<From, To, Address> (
	"Junc is used to create tracks." shared Junc junc,
	"Address this _multiservice_ listens." shared Address address,
	"Limiting number of services. Unlimited If <= 0." Integer serviceNumberLimit = 0
)
		given Address satisfies JuncAddress
{
	
	"Handler which is intended to handle service:
	 [[JuncService.onConnected]], [[JuncService.onError]] and [[JuncService.onClose]].    
	 The handler is instantiated when new service is registered.  
	 "
	see( `interface JuncService` )
	shared formal class ServiceHandler( JuncTrack track ) {
		"Handles service connection request."
		shared formal void connected( JuncSocket<To, From> socket );
		
		"Handles service error."
		shared default void error( Throwable err ) {}
		
		"Handles service close."
		shared default void close() {}
	}
	
	
	"Container for the junc service."
	abstract class ServiceContainer (
		"Track the service is operated on." shared JuncTrack track,
		"Service itself." shared JuncService<From, To> service
	) {
		"Next container in the list or `null` if doesn't exist."
		shared variable ServiceContainer? next = null;
		"Previous container in the list or `null` if doesn't exist."
		shared variable ServiceContainer? prev = null;
	}
	
	
	"Service list operations locker."
	ReentrantLock locker = ReentrantLock();
	
	"Service list."
	variable ServiceContainer? head = null;
	
	"Number of sockets."
	AtomicLong sockets = AtomicLong();
	
	"`True` if registration process of new service is started."
	AtomicBoolean registrationProcessStarted = AtomicBoolean( false );
	
	"Number of opened services."
	AtomicLong numberOfServices = AtomicLong( 0 );
	
	
	class ServiceContainerImpl( JuncTrack track, JuncService<From, To> service )
			extends ServiceContainer( track, service )
	{
		shared void close() {
			track.close();
			locker.lock();
			try {
				if ( exists n = next ) {
					if ( exists p = prev ) {
						n.prev = p;
						p.next = n;
					}
					else {
						head = n;
						n.prev = null;
					}
				}
				else if ( exists p = prev ) {
					p.next = null;
				}
				else {
					head = null;
				}
				next = null;
				prev = null;
				numberOfServices.decrementAndGet();
			}
			finally {
				locker.unlock();
			}
		}
	}
	
	
	void socketClosed() {
		sockets.decrementAndGet();
		locker.lock();
		try {
			// find number of nonblocked services and maximum load level
			variable Integer numberOfNonblockedServices = 0;
			variable LoadLevel maxLoadLevel = LoadLevel.lowLoadLevel;
			variable ServiceContainer? iter = head;
			while ( exists current = iter ) {
				if ( current.service.blocked ) {
					if ( current.service.numberOfSockets == 0 ) {
						// close service if it is blocked and doesn't have any open connection 
						current.service.close();
					}
				}
				else {
					numberOfNonblockedServices ++;
					if ( current.track.loadLevel > maxLoadLevel ) {
						maxLoadLevel = current.track.loadLevel;
					}
				}
				iter = current.next;
			}
			
			if ( numberOfNonblockedServices > 1 && maxLoadLevel != LoadLevel.highLoadLevel ) {
				 // block services with low load level
				 variable Integer totalBlocked = 1;
				 iter = head;
				 while ( exists current = iter ) {
				 	if ( !current.service.blocked && current.track.loadLevel == LoadLevel.lowLoadLevel ) {
				 		current.service.blocked = true;
				 		if ( current.service.numberOfSockets == 0 ) {
				 			current.service.close();
				 		}
				 		totalBlocked ++;
				 		if ( totalBlocked == numberOfNonblockedServices ) {
				 			break; 
				 		}
				 	}
				 	iter = current.next;
				 }
			}
		}
		finally {
			locker.unlock();
		}
	}
	
	void onConnected( JuncSocket<To, From> socket ) {
		sockets.incrementAndGet();
		socket.onClose( socketClosed );
		
		if ( junc.threadable && ( serviceNumberLimit < 1 || serviceNumberLimit > numberOfServices.get() ) ) {
			if ( registrationProcessStarted.compareAndSet( false, true ) ) {
				locker.lock();
				try {
					variable Integer lowLoadNum = 0;
					variable Integer middleLoadNum = 0;
					variable Integer highLoadNum = 0;
					variable ServiceContainer? iter = head;
					while ( exists current = iter, lowLoadNum == 0 ) {
						if ( current.service.blocked ) {
							if ( current.service.numberOfSockets == 0 ) {
								// close service if it is blocked and doesn't have any open connection 
								current.service.close();
							}
						}
						else {
							switch ( current.track.loadLevel )
							case ( LoadLevel.lowLoadLevel ) { lowLoadNum ++; }
							case ( LoadLevel.middleLoadLevel ) { middleLoadNum ++; }
							case ( LoadLevel.highLoadLevel ) { highLoadNum ++; }
						}
						iter = current.next;
					}
					if ( lowLoadNum == 0 && middleLoadNum < 2 && highLoadNum > 0 && junc.threadable ) {
						registerNewService();
					}
					else {
						registrationProcessStarted.compareAndSet( true, false );
					}
				}
				finally {
					locker.unlock();
				}
			}
		}
	}
	
	void onServiceRegistered( JuncTrack track )( JuncService<From, To> service ) {
		numberOfServices.incrementAndGet();
		ServiceContainerImpl container = ServiceContainerImpl( track, service );
		service.onClose( container.close );
		service.onConnected( onConnected );
		
		ServiceHandler handler = ServiceHandler( track );
		service.onConnected( handler.connected );
		service.onError( handler.error );
		service.onClose( handler.close );
		
		locker.lock();
		try {
			container.next = head;
			if ( exists h = head ) {
				h.prev = container;
			}
			head = container;
		}
		finally {
			locker.unlock();
		}
		registrationProcessStarted.compareAndSet( true, false );
	}
	
	
	"Creates new track and register service on it."
	Promise<JuncService<From, To>> registerNewService() {
		return junc.createTrack().compose (
			( JuncTrack track ) {
				return track.registerService<From, To, Address>( address ).onComplete (
					onServiceRegistered( track ),
					( Throwable err ) => track.close()
				);
			}
		);
	}
	
	
	"Registers new service. Returns promise on [[replyContext]] context."
	shared Promise<JuncService<From, To>> registerService (
		"Context returned promise has to work on." Context replyContext
	) => registerNewService().contexting( replyContext );
	
	"Stops all registerd services."
	shared void stopAll() {
		locker.lock();
		try {
			variable ServiceContainer? iter = head;
			while ( exists current = iter ) {
				iter = current.next;
				current.service.close();
			}
		}
		finally {
			locker.unlock();
		}
	}
	
	"Total number of currently opened sockets."
	shared Integer numberOfSockets => sockets.get();
	
}
