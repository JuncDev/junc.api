import herd.junc.api.monitor {
	Monitor
}


"_Junc_"
see( `function Station.start` )
tagged( "work flow" )
by( "Lis" )
shared interface Junc
{
	
	"`True` if more threads may be added and `false` if thread number limit has been reached."
	shared formal Boolean threadable;
	
	"Creates new track independent from this.  
	 Returns `promise` on newly created track.
	 "
	shared formal Promise<JuncTrack> createTrack();
	
	"Creates linked socket pair with first socket works on `first` context and second works on `second` context."
	shared formal [JuncSocket<From, To>, JuncSocket<To, From>] socketPair<From, To> (
		"Context the first socket from the pair to work on." Context first,
		"context the second socket from the pair to work on." Context second
	);
	
	"Creates new messanger which is pair of emitter and publisher, which publishes to the given emitter."
	shared formal [Emitter<Item>, Publisher<Item>] messanger<Item> (
		"Context the messanger is working on." Context context
	);
	
	
	"Deploys new station independent from caller.  
	 Returns promise on specified ([[responseContext]]) or station context
	 and resolved with registration to stop deployed station."
	shared formal Promise<Registration> deployStation (
		"Station to be deployed."
		Station station,
		"Context returned promise has to operate on.  If `null` the promise operates on station context."
		Context? responseContext = null
	);

	
	"Returns a list of registered connectors."
	shared formal ConnectorDescriptor<From, To, Address>[] registeredConnectors<From, To, Address>()
			given Address satisfies JuncAddress;
	
	"Returns a list of registered workshops."
	shared formal WorkshopDescriptor<From, To, Address>[] registeredWorkshops<From, To, Address>()
			given Address satisfies JuncAddress;
	
	
	"_Junc_ monitor which can be used to log and measure the system."
	shared formal Monitor monitor;
	
}
