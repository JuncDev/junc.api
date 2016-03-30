
"Average within measure."
by( "Lis" )
shared interface Average
{
	"Adds sample to average - this will be taken into account when calculating average value."
	shared formal void sample( Float val );
}


"Metric of averaged within measure."
by( "Lis" )
shared interface AverageMetric satisfies Metric
{
	"Measures this metric.  Returns current averaged value."
	shared formal Float measure();
}
