
"Base junc error."
by( "Lis" )
shared abstract class JuncError( "error message" String message )
		of ConnectionError | ContextError | DeliveryError | RegistrationError | GeneralJuncError
		extends Exception( message )
{}


"General error - abstract class which can be extended to implement error logic."
by( "Lis" )
shared abstract class GeneralJuncError (
	"error message" String message
)
		extends JuncError( message )
{}


"Error which contains just message."
by( "Lis" )
shared class AnonymouseError (
	"error message" String message
)
		extends GeneralJuncError( message )
{}
