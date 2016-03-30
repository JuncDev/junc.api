
"[[Promise]] owner and resolver."
see( `interface Promise` )
tagged( "promise" )
by( "Lis" )
shared interface Deferred<Value> satisfies Resolver<Value>
{
	"Promise this deferred possess."
	shared formal Promise<Value> promise;	
}