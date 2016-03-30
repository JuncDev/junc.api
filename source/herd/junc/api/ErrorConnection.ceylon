
"Base class for connection errors."
by( "Lis" )
shared abstract class ConnectionError (
	"Error message." String message
)
		of 	InvalidServiceError | ServiceBlockedError | ServiceClosedError | ConnectionTimeOutError
		extends JuncError( message )
{
	shared actual String string => message;
}



"Error sent when trying to connect to service which doesn't exist or doesn't support requested data type."
by( "Lis" )
shared final class InvalidServiceError()
		extends ConnectionError( "invalid service" )
{}

"Error sent when trying to connect to blocked service."
by( "Lis" )
shared final class ServiceBlockedError()
		extends ConnectionError( "service is blocked" )
{}

"Error sent when trying to connect to closed service."
by( "Lis" )
shared final class ServiceClosedError()
		extends ConnectionError( "service has been closed" )
{}

"Error sent when connection time out has been reached."
by( "Lis" )
shared final class ConnectionTimeOutError()
		extends ConnectionError( "connection time out has been reached" )
{}
