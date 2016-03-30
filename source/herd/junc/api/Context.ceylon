
"Execution context:
 * execution functions within
 * creating promises and resolvers
 "
see( `interface JuncTrack` )
tagged( "work flow" )
by( "Lis" )
shared interface Context {
	
	"Executes function [[run]] on the context."
	shared formal void execute (
		"Function which will be run on the context when context is free."
		Anything() run,
		"Callback to notify if error occured during run."
		Anything(Throwable)? notifyError = null
	);
	
	"Executes on the context function [[run]] with argument [[arg]]."
	shared formal void executeWithArgument<Argument> (
		"Function which will be run on the context when context is free."
		Anything(Argument) run,
		"Argument passed to [[run]] when calling."
		Argument arg,
		"Callback to notify if error occured during run."
		Anything(Throwable)? notifyError = null
	);
	
	"Executes on the context function [[run]] with argument [[arg]]
	 and returns promise on this context and resolved by value returned by execution function.  
	 If [[run]] throws returned promise is rejected with thrown reason."
	shared formal Promise<Result> executeWithResults<Result, Argument> (
		"function which will be run on the context when context is free"
		Result(Argument) run,
		"argument passed to [[run]] when calling"
		Argument arg
	);
	
	"Executes on context function [[run]] with argument [[arg]] 
	 and returns promise on this context and resolved (or rejected) by results returned by execution function.  
	 If [[run]] throws returned promise is rejected with thrown reason."
	shared formal Promise<Result> executeWithPromise<Result, Argument> (
		"Function which will be run on the context when context is free."
		Promise<Result>(Argument) run,
		"Argument passed to [[run]] when calling."
		Argument arg
	);
	
	
	"Creates new promise resolver on this context."
	shared formal Deferred<Value> newResolver<Value>();
	
	"Creates new resolved promise on this context."
	shared formal Promise<Value> resolvedPromise<Value>( Value val );
	
	"Creates new deferred promise on this context."
	shared formal Promise<Value> deferredPromise<Value>( Promise<Value> val );
	
	"Creates new rejected promise on this context."
	shared formal Promise<Nothing> rejectedPromise( Throwable err );
	
}
