
"Counter."
by( "Lis" )
shared interface Counter
{
	"Increments counter value on a number `on`."
	shared formal void increment( Integer on = 1 );
	
	"Decrements counter value on a number `on`."
	shared formal void decrement( Integer on = 1 );
	
	"Resetes counter to value `val`."
	shared formal void reset( Integer val = 0 );
}


"Counter metric - retrieves current counter value."
by( "Lis" )
shared interface CounterMetric satisfies Metric
{
	"Measures this metric.  Returns current counting."
	shared formal Integer measure();
}
