
"
 Contains classes and interfaces the _Junc_ provides as API.  
 Doesn't contain _Junc_ itself and doesn't start _Junc_. `Module herd.junc.core` is responsible for this.  
 
 
 ## Junc elements.
 
 #### Track and work context.
 
 _Work context_ ([[Context]]) is an element which provides execution of functions of any _Junc_ elements.
 I.e. any _Junc_ element executes on one and only one work context. This context provides function execution
 in a given order, so any elements working on the same context can avoid synchronization problems.   
 At the same time work context is not the same as `thread`. Several context can be executed on a one `thread`.
 Morevoer each given context is not attached to some specific `thread`
 and can be moved to another one during lifecycle.
 Context may not be instantiated separately, it is always go together with track.  
 
 _Track_ ([[JuncTrack]]) provides registration, deploying and instantiation _Junc_ elements. 
 Track is provided to _station_ at deploying (see below) also new track may be created using [[Junc.createTrack]].  
 
 
 #### Promise and resolver.
 
 [[Promise]] is a value which may not be available right now.  
 [[Resolver]] is intended to resolve / reject promise.  
 [[Deferred]] is resolver with promise.  
 See [[Context]] methods to create promise and deferred.  
 
 
 #### Emitter, publisher and socket.
 
 [[Emitter]] is some kind of asynchronous stream - it periodically emits some values.  
 [[Publisher]] is an element to publish to the given [[Emitter]].  
 [[JuncSocket]] is intended to communicate to other _Junc_ elements and to the World.  
 Basically, _junc socket_ is a combination of [[Emitter]] and [[Publisher]]. Sockets always work in pair.
 So, first socket in pair publishes to second one and emits values published to paired socket.  
 
 `Emitter / Publisher` pair may be create using [[Junc.messanger]].  
 Socket pair may be created using [[Junc.socketPair]].  
 
 
 #### Message.
 
 [[Message]] is a convinient way to exchange some data, reply on and organize some dialog.  
 May be created using [[JuncTrack.createMessage]].  
 
 
 #### Service.
 
 [[JuncService]] is an element which can be connected to with [[JuncSocket]] and asked to perform some pay load.  
 [[JuncService]] may be registered using [[JuncTrack.registerService]].  
 But to create an instance of [[JuncService]] [[Workshop]] (see below) has to be registered using [[JuncTrack.registerWorkshop]].  
 
 Services are differ by data types and address.  Several services can be registered on the same address.
 In this case _Junc_ chooses specific service when connection is requested by number of actual connections.

  
 #### JuncAddress.
 
 [[JuncAddress]] identifies specific service to connect to by:
 * Actual `type` defines type of service to connect to.
   For example, net or file.
 * Identification within actual type.
   For example, [[ServiceAddress]] uses `String` name.
   Some net service may use host and port identification.
 
 [[ServiceAddress]] is used when registering or connecting to general _Junc_ service.  
 
 
 #### Connector.
 
 Connector is intended to establish connection with specific service (identified by data and address type).  
 To register new connector implement [[Connector]] interface and pass an instance to [[JuncTrack.registerConnector]].   
 
 General _Junc_ connector which provides connection to services using [[ServiceAddress]] is registered internally
 at _Junc_ starting.
 
 > Generally, to connect to service is has to be registerd before using [[JuncTrack.registerService]].
 
 
 #### Workshop.
 
 Workshop provides instantiation of specific services when required.  
 To register new workshop implement [[Workshop]] interface and pass an instance to [[JuncTrack.registerWorkshop]].
 
 General _Junc_ workshop which provides creation of services connected using [[ServiceAddress]] is registered internally
 at _Junc_ starting.
 
 > Once _workshop_ is registered services this workshop provides may be registered using [[JuncTrack.registerService]].
 
 
 #### Station.
 
 Station is a component or _Junc_ work unit.  
 Station may be created by implement [[Station]] interface and deploy an instance using [[Junc.deployStation]].  
 
 
 #### Timer.
 
 Timer is intended to run some tasks on time. To create a timer use [[JuncTrack.createTimer]].
 
 
 ## Usage.
 
 * Implement [[Station]] interface.
 * Provide workshop / connector / service registration.
 * Provide interaction with _Junc_ elements and other stations.
 * Start _Junc_.
 * Deploy stations you need using [[Junc.deployStation]].
 
 
 > `Module herd.junc.core` contains _Junc_ itself and _Junc_ starting function.   
 
 
 ## Service, socket and message example.
 
 		// send / recevied message
 		alias StringMessage => Message<String, String>;
 
 		// service address
  		ServiceAddress address = ServiceAddress(...);
 
 		// register service
 		track.registerService<StringMessage, StringMessage, ServiceAddress>(address).onComplete (
 			(JuncService<StringMessage, StringMessage> service) {
 				service.onConnected (
 					// service connect handler
 					(JuncSocket<StringMessage, StringMessage> socket) {
 						socket.onData (
 							// socket data received handler
 							(StringMessage message) {
 								// replying on received message
 								message.reply (
 									track.createMessage(\"reply\", replyHandler, errorHandler)
 								);
 							}
 						)
 					}
 				);
 			}
 		);
 		
 		...
 		
 		// connecting to service with message
 		track.connect<StringMessage, StringMessage, ServiceAddress>(address).onComplete (
			(JuncSocket<StringMessage, StringMessage> socket) {
				// sending message with replying capability
				socket.publish(track.createMessage(\"message\", replyHandler, errorHandler));
 			}
 		);
 
 
 ## Registeration several services with the same address.
 
 It is possible to register several services with the same address in order to reach some scalability level.  
 When new connection is requested resulting connection is passed to one of registered _services_
 choosen by min number of already opened connections.  
 
 > Services with the same address should be registered on different tracks!
   It allows to listen incoming connections on different tracks
   and possibly on different threads (depending on load level)
   and therefore reach target scalability level.  
 
 Example:
 
 		// service address
  		ServiceAddress address = ServiceAddress(...);
 
 		// register first service
 		value firstTrack = junc.newTrack();
 		firstTrack.registerService<A, B, ServiceAddress>(address).onComplete (
 			(JuncService<A, B> service) {
 				...
 			}
 		);
 
 		// register second service with the same address as first one
 		value secondTrack = junc.newTrack();
 		secondTrack.registerService<A, B, ServiceAddress>(address).onComplete (
 			(JuncService<A, B> service) {
 				...
 			}
 		);
 
 > For services differ from local (connected using [[ServiceAddress]]) this may not be true and depends on
   particular service provider ([[Workshop]]). 
 
 
 ## Logging and application lifecycle monitoring.
 
 Provided via staff of [[package herd.junc.api.monitor]] and [[Junc.monitor]] value.  
 
 
 "
by( "Lis" )
native( "jvm" )
module herd.junc.api "0.1.0" {
	shared import java.base "8";
	import ceylon.collection "1.2.2";
}
