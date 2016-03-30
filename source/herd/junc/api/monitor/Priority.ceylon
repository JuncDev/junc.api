
"The importance of a log message. `Priority`s have a total
 order running from most important to least important."
shared class Priority
		of fatal | error | warn | info | debug | trace 
		satisfies Comparable<Priority>
{
	"The name of this priority."
	shared actual String string;
	
	"An integer measuring the importance of this `Priority`."
	Integer integer;
	
	
	"A serious failure, usually leading to program termination."
	shared new fatal {
		string = "FATAL";
		integer = 100;
	}
	
	"An error, often causing the program to abandon its current work."
	shared new error {
		string = "ERROR";
		integer = 90;
	}
	
	"A warning, usually indicating that the program can continue with its current work."
	shared new warn {
		string = "WARN";
		integer = 80;
	}
	
	"An important event in the program lifecycle."
	shared new info {
		string = "INFO";
		integer = 70;
	}
	
	"An event that is only interesting when debugging the program."
	shared new debug {
		string = "DEBUG";
		integer = 60;
	}
	
	"An event that is only interesting when the programmer is pulling out hair while debugging the program."
	shared new trace {
		string = "TRACE";
		integer = 50;
	}
	
	
	compare(Priority other) => integer <=> other.integer;
	
	"Returns priority from string representation (FATAL, ERROR, WARN, INFO, DEBUG or TRACE)."
	shared Priority? fromString( String priorityName ) {
		switch ( priorityName.uppercased )
		case ( "FATAL" ) { return fatal; }
		case ( "ERROR" ) { return error; }
		case ( "WARN" ) { return warn; }
		case ( "INFO" ) { return info; }
		case ( "DEBUG" ) { return debug; }
		case ( "TRACE" ) { return trace; }
		else { return null; }
	}
}
