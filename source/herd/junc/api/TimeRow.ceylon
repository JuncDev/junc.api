
"Represents a row or chain of times."
see( `interface Timer`, `function JuncTrack.createTimer` )
tagged( "timer" )
by( "Lis" )
shared interface TimeRow
{
	"Starts the timing from beginning.  Returns next time in milliseconds or `null` if completed."
	see( `function resume` )
	see( `function pause` )
	shared formal Integer? start( "Time to start from, in milliseconds." Integer current );
	
	"Pauses timing. [[resume]] to be called to resume timing."
	see( `function resume` )
	see( `function start` )
	shared formal void pause();
	
	"Resumes timing after pausing.  Returns next time in milliseconds or `null` if completed."
	see( `function pause` )
	see( `function start` )
	shared formal Integer? resume( "Time to resume from, in milliseconds." Integer current );
	
	"Next time in milliseconds or `null` if time chain is exhausted."
	shared formal Integer? nextTime();
	
}
