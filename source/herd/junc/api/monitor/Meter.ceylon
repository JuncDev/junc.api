
"Meter is a mean rate at which a set of events occur."
by( "Lis" )
shared interface Meter
{
	"Ticks the meter with `n` events."
	shared formal void tick( Integer n = 1 );
}


"Metric of meter."
by( "Lis" )
shared interface MeterMetric satisfies Metric
{
	"Measures this metric.  Returns rate in seconds."
	shared formal Float measure();
}
