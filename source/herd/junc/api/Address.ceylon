
"Base address used within _Junc_.  
 Memoizes hash code and calculates it using [[calculateHash]].
 "
tagged( "communication" )
by( "Lis" )
shared abstract class JuncAddress() extends Object()
{
	variable Integer memoizedHash = 0;

	"Calculates hash code."
	shared formal Integer calculateHash();
	
	shared actual Integer hash {
		if ( memoizedHash == 0 ) {
			memoizedHash = calculateHash();
		}
		return memoizedHash;
	}
	
}


"General (or local) _Junc_ service address."
tagged( "communication" )
by( "Lis" )
shared final class ServiceAddress( shared String service ) extends JuncAddress() {
	
	shared actual Boolean equals( Object that ) {
		if ( is ServiceAddress that ) { return service == that.service; }
		else { return false; }
	}
	
	shared actual Integer calculateHash() => 17 + 41 * ( 41 * "junc://".hash + service.hash );
	
	shared actual String string => "junc://" + service;
	
}
