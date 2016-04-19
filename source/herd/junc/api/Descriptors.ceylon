

"Descriptor of [[Connector]], can be used to determine exact type."
see( `class ConnectorAddedEvent`, `class ConnectorRemovedEvent`, `function Junc.registeredConnectors` )
tagged( "work flow" )
by( "Lis" )
shared interface ConnectorDescriptor<in From, in To, in Address>
		given Address satisfies JuncAddress
{
	shared actual default String string => "connector descriptor: 'from' type `` `From` ``, 'to' type `` `To` `` and address type `` `Address` ``";
}

"Connector descriptor of any type."
see( `class ConnectorAddedEvent`, `class ConnectorRemovedEvent`, `function Junc.registeredConnectors` )
tagged( "work flow" )
by( "Lis" )
shared interface ConnectorDescriptorAny => ConnectorDescriptor<Nothing, Nothing, Nothing>;


"Descriptor of [[Workshop]], can be used to determine exact type."
see( `class WorkshopAddedEvent`, `class WorkshopRemovedEvent`, `function Junc.registeredWorkshops` )
tagged( "work flow" )
by( "Lis" )
shared interface WorkshopDescriptor<in From, in To, out Address>
		given Address satisfies JuncAddress
{
	
	"Returns a list of available services with given types."
	shared formal {ServiceDescriptor<Send, Receive, Address>*} services<Send, Receive>()
			given Send satisfies From
			given Receive satisfies To;
	
	shared actual default String string => "workshop descriptor: 'from' type `` `From` ``, 'to' type `` `To` `` and address type `` `Address` ``";
}

"Connector descriptor of any type."
see( `class WorkshopAddedEvent`, `class WorkshopRemovedEvent`, `function Junc.registeredWorkshops` )
tagged( "work flow" )
by( "Lis" )
shared interface WorkshopDescriptorAny => WorkshopDescriptor<Nothing, Nothing, Anything>;


"Descriptor of [[JuncService]]:
 * type
 * address
 * total number of registered services
 "
see( `class ServiceAddedEvent`, `class ServiceClosedEvent` )
tagged( "work flow" )
by( "Lis" )
shared interface ServiceDescriptor<in From, in To, out Address> given Address satisfies JuncAddress
{
	"Address this service listens to."
	shared formal Address address;
	
	"Total number of services registered with address [[address]]."
	shared formal Integer count;
	
	shared actual default String string => "service descriptor: 'from' type `` `From` ``, 'to' type `` `To` ``, address ``address``, total services ``count``";

}

"Service descriptor of any type."
see( `class ServiceAddedEvent`, `class ServiceClosedEvent` )
tagged( "work flow" )
by( "Lis" )
shared interface ServiceDescriptorAny => ServiceDescriptor<Nothing, Nothing, Anything>;

