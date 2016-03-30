
"Publishing some values."
see( `interface Emitter`, `interface JuncSocket`, `function Junc.messanger` )
tagged( "communication" )
by( "Lis" )
shared interface Publisher<in Item>
{
	
	"`True` if closed and `false` otherwise."
	shared formal Boolean closed;
	
	"Publishes value."
	shared formal void publish<SubItem>( SubItem msg ) given SubItem satisfies Item;
	
	"Publishes error."
	shared formal void error( Throwable error );
	
	"Publishes close."
	shared formal void close();
		
}
