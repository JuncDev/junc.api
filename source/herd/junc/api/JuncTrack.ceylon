
"Track is like a artery of the _Junc_. Provides:
 * work context to execute functions and methods of _junc_ elements.
 * instantiation, registration  and deploying _junc_ elements
 "
see( `function Station.start`, `function Junc.newTrack` )
tagged( "work flow" )
by( "Lis" )
shared interface JuncTrack
{
	"Work context all functions (promises, timers, sockets, services) within _junc track_ are executed on this work context."
	shared formal Context context;
	
	"Load level on the track."
	shared formal LoadLevel loadLevel;
	
	"`True` if this track has been closed and `false` otherwise."
	shared formal Boolean closed;
	
	"Closes this track."
	shared formal void close();
	
	
	"Emitting overall _Junc_ events."
	shared formal Emitter<JuncEvent> juncEvents;


	"Creates new timer based on time row."
	shared formal Timer createTimer( "Time row created timer has to follow." TimeRow timeRow );

	"Creates new message."
	shared formal Message<Body, Reply> createMessage<Body, Reply> (
		"Message body." Body body,
		"Optional message reply handler." Anything(Message<Reply, Body>)? replyHandler = null,
		"Optional message rejection handler." Anything(Throwable)? rejectHandler = null
	);


	"Connects to remote [[address]]."
	shared formal Promise<JuncSocket<To, From>> connect<To, From, Address> (
		"Address to connect to." Address address
	) given Address satisfies JuncAddress;
	
	"Registers new service on this track.  
	 Returns promise resolved with created service or rejected if some error occured."
	shared formal Promise<JuncService<From, To>> registerService<From, To, Address> (
		"Address of newly created service." Address address
	) given Address satisfies JuncAddress;
	
	"Registers new workshop.  
	 [[Workshop.provideService]] will be called on this track.  
	 Returns promise resolved with registration to close this workshop
	 or rejected if workshop utilazies scheme `scheme` which has been registered before."
	shared formal Promise<Registration> registerWorkshop<From, To, Address> (
		"Workshop to be registered." Workshop<From, To, Address> workshop
	) given Address satisfies JuncAddress;
	
	"Registers new connector with scheme `scheme`.
	 [[Connector.connect]] will be called on this track.    
	 Returns promise resolved with registration to close this connector 
	 or rejected if connector utilazies scheme `scheme` which has been registered before."
	shared formal Promise<Registration> registerConnector<From, To, Address> (
		"Connector to be registered." Connector<From, To, Address> connector
	) given Address satisfies JuncAddress;
	
	
	"Executes a function which may take a long period to run.
	 The function is executed in separated thread from a thread pool.  
	 If all threads from the pool are busy the function is added to execution queue and will be executed late."
	shared formal Promise<Result> executeBlocked<Result>( Result() run );
	
}
