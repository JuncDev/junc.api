import ceylon.language.meta.model {
	Type
}



"Base error occured during message delivering."
by( "Lis" )
shared abstract class DeliveryError( "Error message." String message )
		of InvalidRequest<Anything> | InvalidType
		extends JuncError( message )
{
	shared actual String string => "delivery error : message";
}

"Error sent when invalid request is received by service."
by( "Lis" )
shared final class InvalidRequest<out Request>( shared Request request ) extends DeliveryError( "invalid request" ) {
}

"Error sent when invalid type of request is received by service."
by( "Lis" )
shared final class InvalidType( shared Type<> type ) extends DeliveryError( "invalid request type " + type.string ) {
}
