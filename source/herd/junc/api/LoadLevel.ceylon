

"_Junc track_ load level: low, middle or high."
see( `value JuncTrack.loadLevel` )
tagged( "work flow" )
by( "Lis" )
shared class LoadLevel
	of lowLoadLevel | middleLoadLevel | highLoadLevel
{
	"Load level is low."
	shared new lowLoadLevel {}
	
	"Load level is middle."
	shared new middleLoadLevel {}
	
	"Load level is high."
	shared new highLoadLevel {}
}

