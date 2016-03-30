
"Base context error."
by( "Lis" )
shared abstract class ContextError( "error message" String message )
		of ContextStoppedError
		extends JuncError( message )
{}


"Error sent when execution on stopped context is requested."
by( "Lis" )
shared final class ContextStoppedError() extends ContextError( "context has been stopped" ) {}
