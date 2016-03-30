
"
 Station is an assembly or module which works on _Junc_.  
 Usage:  
 Implement and deploy an instance using [[Junc.deployStation]].  
"
see( `function Junc.deployStation` )
tagged( "work flow" )
by( "Lis" )
shared interface Station
{
	"Starts the station."
	shared formal Promise<Object> start (
		"Track the station may operate with." JuncTrack track,
		"Junc to operate with." Junc junc
	);
}
