
"
 Workshop is [[JuncService]] factory and maintainer responsible for
 creating and maintaining services of particular type
 (read [[JuncAddress]] subtype and given send/receive data types).  
 
 Steps to setup new workshop:  
 1. Declare address which the workshop services use and which identifies services type.  
 2. Implement [[Workshop]] interface.  
 3. Provide a way created services to work in asynchronous manner. 
 4. Push implemented workshop to [[JuncTrack.registerWorkshop]] method.  
 
 `Workshop` interface declares just a one method - [[provideService]]
   which is called internally by _Junc_ when service registration is requested
   with parameters the workshop supports.
   Workshop is responsible that all created services do not block but work in ansynchronous manner.  
 "
see( `interface JuncService`, `function JuncTrack.registerWorkshop` )
tagged( "communication" )
by( "Lis" )
shared interface Workshop<in From, in To, in Address>
		given Address satisfies JuncAddress
{
	"Creates new service.  
	 Has to return promise on [[track]] resolved with message with newly created service
	 or rejected if error occured.  
	 The message will be replied when service is actually starts listens on connections and so
	 may establish connections to.
	 "
	shared formal Promise<Message<JuncService<Send, Receive>, Null>> provideService<Send, Receive> (
		"Service address." Address address,
		"Track service has to work on" JuncTrack track
	)
			given Send of From
			given Receive of To;
	
}
