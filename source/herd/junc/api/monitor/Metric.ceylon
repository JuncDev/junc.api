
"Metric - measured value:
 * gauge [[GaugeMetric]]
 * counter [[CounterMetric]]
 * meter [[MeterMetric]]
 * average [[AverageMetric]]
 "
by( "Lis" )
shared interface Metric
	of GaugeMetric<Anything> | CounterMetric | MeterMetric | AverageMetric
{
	"Metric name."
	shared formal String name;
}
