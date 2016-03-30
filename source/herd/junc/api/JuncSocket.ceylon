
"Socket - as pair of emitter and publisher."
see( `function Junc.socketPair`, `interface JuncService` )
tagged( "communication" )
by( "Lis" )
shared interface JuncSocket<in Emit, in Publish> satisfies Emitter<Emit> & Publisher<Publish>
{}
