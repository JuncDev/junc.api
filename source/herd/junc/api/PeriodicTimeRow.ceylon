
"Time row with period."
see( `interface Timer`, `function JuncTrack.createTimer` )
tagged( "timer" )
by( "Lis" )
shared class PeriodicTimeRow (
	"Fire period." Integer period,
	"Repeat counts. Infinite if <= 0." Integer repeat = 0
	
)
		satisfies TimeRow
{
	
	variable Integer repeated = 0;
	variable Integer? lastTime = null;
	
	
	shared actual Integer? nextTime() {
		if ( exists l = lastTime ) {
			if ( repeat > 0 ) {
				repeated ++;
				if ( repeated > repeat ) { return null; }
			}
			lastTime = l + period;
			return lastTime;
		}
		else { return null; }
	}
	
	shared actual void pause() { lastTime = null; }
	
	shared actual Integer? resume( Integer current ) {
		if ( !lastTime exists ) {
			if ( repeat > 0 && repeated > repeat ) { return null; }
			lastTime = current + period;
		}
		return lastTime;
	}
	
	shared actual Integer? start( Integer current ) {
		if ( !lastTime exists ) {
			repeated ++;
			lastTime = current + period;
		}
		return lastTime;
	}
	
}
