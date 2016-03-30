
"Staff to incorporate application lifecycle monitoring.
 
 Object of [[Monitor]] interface is available via [[herd.junc.api::Junc]] and provides
 logging and instrumenting capabilities.
 
 #### Logging.
 To write logs [[LogWriter]] has to be registerd within [[Monitor]] object.  
 Log is pushed using `Monitor.logXXX` methods.  
 
 #### Metrics.
 To write metrics [[MetricWriter]] has to be registerd within [[Monitor]] object.  
 Metrics can be created using corresponding methods of [[Monitor]] object.  
 Available metrics:
 * [[Gauge]] represents a value, created using [[Monitor.gauge]]
 * [[Counter]] represents a counter, create using [[Monitor.counter]]
 * [[Average]] represents a value average by all submited samples, create using [[Monitor.average]]
 * [[Meter]] represents a mean rate at which a set of events occur, create using [[Monitor.meter]]
 
 "
by( "Lis" )
shared package herd.junc.api.monitor;
