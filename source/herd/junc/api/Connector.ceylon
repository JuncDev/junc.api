
"
 Connector is intended to establish and maintain connections to some service outside _Junc_.
 That service may be, for example, a file or TCP client.  
 
 Steps to setup new connector:  
 1. Declare address the connector will use. The address has to extends [[JuncAddress]].    
 2. Implement `Connector` interface.  
 3. Provide a way to interact with outside service in asynchronous manner.  
 4. Push implemented connector to [[JuncTrack.registerConnector]] method.  
 
 `Connector` interface has just a one method [[connect]],
 which is called by _Junc_ when new connection with address type supported by the given connector is requested.
 Connector is responsible to treat and maintain all requests from client
 and to redirect them to (or from) the service it represents in asynchronous way.
"
see( `function JuncTrack.registerConnector`, `function JuncTrack.connect`, `function Junc.socketPair` )
tagged( "communication" )
by( "Lis" )
shared interface Connector<in From, in To, in Address>
		given Address satisfies JuncAddress
{
	"Treats the request to establish new connection.  
	 Has to return `promise` on [[clientContext]] resolved with socket connected to 'remote address'
	 or rejected if error occured."
	shared formal Promise<JuncSocket<Send, Receive>> connect<Send, Receive> (
		"Address to connect to." Address address,
		"Client context." Context clientContext
	)
			given Send of From
			given Receive of To;
	
}
