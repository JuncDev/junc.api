
"Base class events occured on _Junc_."
see( `value JuncTrack.juncEvents` )
tagged( "work flow" )
by( "Lis" )
shared abstract class JuncEvent()
		of	ServiceAddedEvent<Nothing, Nothing, JuncAddress> | ServiceClosedEvent<Nothing, Nothing, JuncAddress>
			| ConnectorAddedEvent<Nothing, Nothing, Nothing> | ConnectorRemovedEvent<Nothing, Nothing, Nothing>
			| WorkshopAddedEvent<Nothing, Nothing, JuncAddress> | WorkshopRemovedEvent<Nothing, Nothing, JuncAddress>
{}


"New service has been added event."
tagged( "work flow" )
by( "Lis" )
shared final class ServiceAddedEvent<in From, in To, out Address> (
	"Descriptor of added service." shared ServiceDescriptor<From, To, Address> service
)
		extends JuncEvent()
		given Address satisfies JuncAddress
{
	shared actual String string => "Event: ``service`` has been added";
}

"Service has been closed event."
tagged( "work flow" )
by( "Lis" )
shared final class ServiceClosedEvent<in From, in To, out Address> (
	"Descriptor of closed service." shared ServiceDescriptor<From, To, Address> service
)
		extends JuncEvent()
		given Address satisfies JuncAddress
{
	shared actual String string => "Event: ``service`` has been closed";
}


"New connector has been added event."
tagged( "work flow" )
by( "Lis" )
shared final class ConnectorAddedEvent<in From, in To, in Address> (
	"Descriptor of added connector." shared ConnectorDescriptor<From, To, Address> connector
)
		extends JuncEvent()
		given Address satisfies JuncAddress
{
	shared actual String string => "Event: ``connector`` has been added";
}

"Connector has been removed event."
tagged( "work flow" )
by( "Lis" )
shared final class ConnectorRemovedEvent<in From, in To, in Address> (
	"Descriptor of removed connector." shared ConnectorDescriptor<From, To, Address> connector
)
		extends JuncEvent()
		given Address satisfies JuncAddress
{
	shared actual String string => "Event: ``connector`` has been removed";
}


"New workshop has been added event."
tagged( "work flow" )
by( "Lis" )
shared final class WorkshopAddedEvent<in From, in To, out Address> (
	"Descriptor of added workshop." shared WorkshopDescriptor<From, To, Address> workshop
)
		extends JuncEvent()
		given Address satisfies JuncAddress
{
	shared actual String string => "Event: ``workshop`` has been added";
}

"Workshop has been removed event."
tagged( "work flow" )
by( "Lis" )
shared final class WorkshopRemovedEvent<in From, in To, out Address> (
	"Descriptor of removed workshop." shared WorkshopDescriptor<From, To, Address> workshop
)
		extends JuncEvent()
		given Address satisfies JuncAddress
{
	shared actual String string => "Event: ``workshop`` has been removed";
}

