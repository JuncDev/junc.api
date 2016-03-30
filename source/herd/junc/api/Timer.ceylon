
"Timer - periodically emission of time events."
see( `interface TimeRow`, `function JuncTrack.createTimer` )
tagged( "timer" )
by( "Lis" )
shared interface Timer satisfies Emitter<TimeEvent>
{
	"Starts the timer now."
	shared formal void start();
	
	"Stops the timer, so it will never emit."
	shared formal void stop();
	
	"Pauses the timer.  No emissions while [[resume]] called."
	shared formal void pause();
	
	"Resumes the timer after pausing."
	shared formal void resume();
}
