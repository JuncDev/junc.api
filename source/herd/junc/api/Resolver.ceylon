
"Resolver interface - resolves or rejects promised value."
see( `interface Promise`, `interface Deferred` )
tagged( "promise" )
by( "Lis" )
shared interface Resolver<in Value>
{
	"Resolves `promise` with specified value."
	see( `function defer` )
	see( `function reject` )
	shared formal void resolve( "Value the `promise` is resolved with." Value val );
	
	"Resolves `promise` with another one - so it will be resolved when [[other]] resolved."
	see( `function resolve` )
	see( `function reject` )
	shared formal void defer( "Other `promise` to resolve this with promised value." Promise<Value> other );
	
	"Rejects `promise` with specified `reason`."
	see( `function resolve` )
	see( `function defer` )
	shared formal void reject( "Reason the `promise` is rejected with." Throwable reason );

}
