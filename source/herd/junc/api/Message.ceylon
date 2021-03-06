
"Messages provide a way to organize dialogs:
 once message is received it may be replied with some data or rejected with an error.
 "
see( `function JuncTrack.createMessage` )
tagged( "communication" )
by( "Lis" )
shared interface Message<Body, Reply>
{
	"Message body."
	shared formal Body body;
	
	"Replies to the message if reply handler is defined."
	shared formal void reply( "Message to reply with." Message<Reply, Body> repliedMessage );
	
	"Rejects the message if reject handler is defined."
	shared formal void reject( "Rejection reason." Throwable reason );
}
