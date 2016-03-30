
"Gauge as value storage."
by( "Lis" )
shared interface Gauge<in T>
{
	"Puts the value to the gauge."
	shared formal void put( T val );
}


"Metric of gauge."
by( "Lis" )
shared interface GaugeMetric<out T> satisfies Metric
{
	"Measures this metric.  Returns current gauge value or null if gauge hasn't been set."
	shared formal T? measure();
	
	"Returns string representation from value returned by `measure` or \"<null>\" otherwise."
	shared actual default String string => measure()?.string else "<null>";
}
