
"_Junc_ service is an element which can be connected to with [[JuncSocket]] and asked to perform some pay load."
see( `function JuncTrack.registerService`, `function JuncTrack.connect` )
tagged( "communication" )
by( "Lis" )
shared interface JuncService<in From, in To>
{
	"Address this service listens to."
	shared formal JuncAddress address;
	
	"Current number of sockets in the service."
	shared formal Integer numberOfSockets;
	
	"If `true` any new connections to service are blocked."
	shared formal variable Boolean blocked;
	
	"`True` if service has been closed and `false` otherwise."
	shared formal Boolean closed;
	
	"Closes this service."
	shared formal void close();
	
	
	"Adds connection listeners which will be called at new connection request.  
	 Returns registration to cancel listenning."
	shared formal Registration onConnected<Receive, Send>( void connected( JuncSocket<Receive, Send> socket ) )
			given Receive satisfies To
			given Send satisfies From;
	
	"Adds service error listener.  
	 Returns registration to cancel listenning."
	shared formal Registration onError( void error( Throwable err ) );
	
	"Adds close listener.  
	 Returns registration to cancel listenning."
	shared formal Registration onClose( void close() );
	
}
