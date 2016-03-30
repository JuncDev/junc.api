
"Event from timer."
see( `interface Timer` )
tagged( "timer" )
by( "Lis" )
shared class TimeEvent (
	"Timer produces this event." shared Timer timer,
	"System time at which event raised, milliseconds." shared Integer time,
	"Total number the timer fires." shared Integer count
) {}
