
"Monitoring of application lifecycle."
by( "Lis" )
shared interface Monitor
{
	"Logs from specified `identifier` with given `priority` and `message` and optionally `throwable`."
	shared formal void log (
		"Identifier of the item which writes this log message." String identifier,
		"Priority of the log message." Priority priority,
		"Log message." String message,
		"Optional `Throwable` which may cause this log message." Throwable? throwable = null
	);
	
	"Determines if log messages with the given priority will be sent."
	shared formal Boolean enabled( "Priority to be checked." Priority priority );
	
	"Logs fatal."
	see( `function log` )
	shared default void logFatal( String identifier, String message, Throwable? throwable = null )
		=> log( identifier, Priority.fatal, message, throwable );
	
	"Logs error."
	see( `function log` )
	shared default void logError( String identifier, String message, Throwable? throwable = null )
			=> log( identifier, Priority.error, message, throwable );
	
	"Logs warning."
	see( `function log` )
	shared default void logWarn( String identifier, String message, Throwable? throwable = null )
			=> log( identifier, Priority.warn, message, throwable );
	
	"Logs info."
	see( `function log` )
	shared default void logInfo( String identifier, String message, Throwable? throwable = null )
			=> log( identifier, Priority.info, message, throwable );
	
	"Logs debug."
	see( `function log` )
	shared default void logDebug( String identifier, String message, Throwable? throwable = null )
			=> log( identifier, Priority.debug, message, throwable );
	
	"Logs trace."
	see( `function log` )
	shared default void logTrace( String identifier, String message, Throwable? throwable = null )
			=> log( identifier, Priority.trace, message, throwable );
	
	
	"`True` if contains gauge with name `name` and `false` otherwise."
	shared formal Boolean containsGauge( String name );
	
	"Returns gauge with name `name`.  
	 If gauge doesn't exist new one is created otherwise existed gauge is returned.  
	 Returns `null` if gauge with the same name but with another type `T` already exists."
	shared formal Gauge<T>? gauge<T>( String name );
	
	"Removes gauge with name `name`."
	shared formal void removeGauge( String name );
	
	
	"`True` if contains counter with name `name` and `false` otherwise."
	shared formal Boolean containsCounter( String name );
	
	"Returns counter with name `name`.  
	 If counter doesn't exist new one is created otherwise existed counter is returned"
	shared formal Counter counter( String name );
	
	"Removes counter with name `name`."
	shared formal void removeCounter( String name );
	
	
	"`True` if contains meter with name `name` and `false` otherwise."
	shared formal Boolean containsMeter( String name );
	
	"Returns meter with name `name`.  
	 If meter doesn't exist new one is created otherwise existed meter is returned"
	shared formal Meter meter( String name );
	
	"Removes meter with name `name`."
	shared formal void removeMeter( String name );
	
	
	"`True` if contains average with name `name` and `false` otherwise."
	shared formal Boolean containsAverage( String name );
	
	"Returns average with name `name`.  
	 If average doesn't exist new one is created otherwise existed average is returned"
	shared formal Average average( String name );
	
	"Removes average with name `name`."
	shared formal void removeAverage( String name );
	
}
