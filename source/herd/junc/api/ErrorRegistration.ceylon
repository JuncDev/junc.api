
"Base error with registration"
by( "Lis" )
shared abstract class RegistrationError (
	"Error message." String message
)
		of JuncStoppedError | ServiceRegistrationError | ConnectorRegistrationError | WorkshopRegistrationError
		extends JuncError( message )
{
	shared actual String string => message;
	
}


"Error sent when requesting to _Junc_ after stopping."
by( "Lis" )
shared final class JuncStoppedError() extends RegistrationError( "service registration error" )
{}


"Error sent when requested service cann't be registered."
see( `function JuncTrack.registerService` )
by( "Lis" )
shared final class ServiceRegistrationError() extends RegistrationError( "service registration error" )
{}


"Error sent when requested connector cann't be registered."
see( `function JuncTrack.registerConnector` )
by( "Lis" )
shared final class ConnectorRegistrationError() extends RegistrationError( "connector registration error" )
{}


"Error sent when requested workshop cann't be registered."
see( `function JuncTrack.registerWorkshop` )
by( "Lis" )
shared final class WorkshopRegistrationError() extends RegistrationError( "workshop registration error" )
{}

