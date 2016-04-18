

"_Junc track_ load level: low, middle or high."
see( `value JuncTrack.loadLevel` )
tagged( "work flow" )
by( "Lis" )
shared class LoadLevel
	of lowLoadLevel | middleLoadLevel | highLoadLevel
	satisfies Comparable<LoadLevel>
{
	Integer level;
	
	"Load level is low."
	shared new lowLoadLevel { level = 1; }
	
	"Load level is middle."
	shared new middleLoadLevel { level = 2; }
	
	"Load level is high."
	shared new highLoadLevel { level = 3; }
	
	
	shared actual Comparison compare( LoadLevel other ) => level <=> other.level;
	
}

