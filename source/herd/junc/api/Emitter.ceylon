
"Some kind of asynchronous stream which periodically emits some values.  
 
 Emitter may be subscribed to receive only given subtype.  
 For example:
 
 		abstract class Transaction() of OpenTransaction | SecureTransaction {}
 
 		class OpenTransaction() extends Transaction() {}
 		class SecureTransaction() extends Transaction() {}
 		
 		...
 		
 		Emitter<Transaction> emitter = ...
 		emitter.onData (
 			(OpenTransaction data) {
 				...
 			}
 		);
 		emitter.onData (
 			(SecureTransaction data) {
 				...
 			}
 		);
 
 "
see( `interface Publisher`, `interface JuncSocket`, `function Junc.messanger` )
tagged( "communication" )
by( "Lis" )
shared interface Emitter<in Item>
{
	
	"Adds emit handlers - data, error and close."
	shared formal Registration onEmit<SubItem> (
		"Handler that called when data received, only items of `SubItem` will be pushed to [[data]]."
		Anything(SubItem) data,
		"Handler that called when error occured."
		Anything(Throwable) error,
		"Handler that called when socket closed."
		Anything() close
	) given SubItem satisfies Item;
	
	"Adds data emit handler."
	shared formal Registration onData<SubItem> (
		"Handler that called when data received, only items of `SubItem` will be pushed to [[data]]."
		Anything(SubItem) data
	) given SubItem satisfies Item;
	
	"Adds error handler."
	shared formal Registration onError (
		"Handler that called when error occured."
		Anything(Throwable) error
	);
	
	"Adds close handler."
	shared formal Registration onClose (
		"Handler that called when socket closed."
		Anything() close
	);
	
}
