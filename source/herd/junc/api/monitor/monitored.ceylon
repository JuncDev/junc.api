
"Names of monitored values used within _Junc_."
by( "Lis" )
shared object monitored
{
	
	shared String delimiter = ".";
	
	shared String junc = "junc";
	shared String core = "junc" + delimiter + "core";
	shared String numberOfThreads = core + delimiter + "number of threads";
	
	shared String thread = core + delimiter + "thread";
	shared String threadLoadLevel = "load level";
	shared String threadQueuePerLoop = "size of queue per loop";
	
	shared String numberOfStations = core + delimiter + "stations";
	
	shared String numberOfSockets ="number of sockets";
	shared String connectionRate = "connection rate";
	
}
