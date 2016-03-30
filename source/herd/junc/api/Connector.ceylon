
"Establish connections."
see( `function JuncTrack.registerConnector`, `function JuncTrack.connect` )
tagged( "communication" )
by( "Lis" )
shared interface Connector<in From, in To, in Address>
		given Address satisfies JuncAddress
{
	"Creates new connection.  
	 Returns promise on [[clientContext]] resolved with socket to connect to remote address or rejected with error is occcurs."
	shared formal Promise<JuncSocket<Send, Receive>> connect<Send, Receive> (
		"Address to connect to." Address address,
		"Client context." Context clientContext
	)
			given Send of From
			given Receive of To;
	
}
