
"Promise is a value which may not be available right now.  
 Promise can be in one of following states:
 * promised - value is not available yet
 * resolved - value is available now and complete handler is called immediately 
 * rejected - promise is rejected and reject handler is called immediately
 
 ####usage:
 	Deferred<Type> def = Deferred<Type>();
 	return def.promise;
 	
 	...
 	
 	promise.onCompleted( (Type val) => /*to do with val*/, (Throwable reason) =>/*to do with reason*/ );
 	
 	...
 	
 	def.resolve( val );
 	// or def.reject( reason );
 	
 "
see( `interface Resolver`, `interface Deferred` )
tagged( "promise" )
by( "Lis" )
shared interface Promise<out Value>
{
	
	"Adds complete / reject handlers to the promise.  
	 Returns `this` promise so it can be chained."
	shared formal Promise<Value> onComplete (
		"Handler called when promise is resolved." Anything(Value) completeHandler,
		"Handler called when promise is rejected." Anything(Throwable)? rejectHandler = null
	);
	
	"Adds reject handler to the promise.  
	 Returns `this` promise so it can be chained."
	shared formal Promise<Value> onError( "Handler called when promise is rejected." Anything(Throwable) rejectHandler );
	
	
	"Composes this promise with another - returned by [[mapping]] when this promise is resolved.  
	 Returns promise on [[context]] which is resolved with returned value of [[mapping]]
	 or rejected with the same reason as this promise rejected.  
	 [[mapping]] is to be called on this promise context."
	shared formal Promise<Result> compose<Result> (
		"Handler called on this promise context when this promise resolved." Promise<Result>(Value) mapping,
		"Context composed promise works on. If `null` context of the this promise is used." Context? context = null
	);
	
	"Maps the promise to obtain another results.  
	 Returns promise on [[context]] resolved with mapped result when this promise resolved
	 or rejected with the same reason as this.  
	 [[mapping]] is to be called on this promise context."
	shared formal Promise<Result> map<Result> (
		"Mapping function called on this promise context." Result mapping( Value val ),
		"Context composed promise works on. If `null` context of the this promise is used." Context? context = null
	);
	
	"Combines with another promise and returns mapped result of both.  
	 Returns promise on [[context]] resolved with mapped value oth this and [[other]].   
	 [[mapping]] is to be called on this promise context."
	shared formal Promise<Result> and<Result, Other> (
		"Promise to combine with."
		Promise<Other> other,
		"Mapping function to combine results of this and other promises, called on this promise context."
		Promise<Result> mapping( Value val, Other otherVal ),
		"Context composed promise works on. If `null` context of the this promise is used"
		Context? context = null
	);
	
	"Returns promise resolved with the same value as current promise but acts on [[other]] context."
	shared formal Promise<Value> contexting( "Context returned promise to work on." Context other );
	
}
