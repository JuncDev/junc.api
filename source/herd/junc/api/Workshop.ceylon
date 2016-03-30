
"[[JuncService]] factory.  
 Services are identified by type of data and type of address.
 "
see( `interface JuncService`, `function JuncTrack.registerWorkshop` )
tagged( "communication" )
by( "Lis" )
shared interface Workshop<in From, in To, in Address>
		given Address satisfies JuncAddress
{
	"Creates new service.  
	 Returns promise on [[context]] resolved with newly created service or rejected with error if occured."
	shared formal Promise<JuncService<Send, Receive>> provideService<Send, Receive> (
		"Service address." Address address,
		"Context service has to work on" Context context
	)
			given Send of From
			given Receive of To;
	
}
