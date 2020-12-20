# Neural Stream
A library for neurologically oriented programming.

1. Not type bound
Unlike a regular stream a neural stream is not bound to a specific type. 
This allows the user to manage all their events from a single stream.

2. Automatic event chaining
Another key difference of the neural stream is that the output of a listener will automatically be passed back through the stream.
The same is true for any exceptions which are thrown during a listener's computation.

This provides a mechanism for chaining reactions together without pulling the stream into the 
scope of the reaction. 

## Getting Started
``` Dart
import 'package:event_stream/event_stream.dart';

void main() {

    NeuralStream stream = NeuralStream();
    
    stream.listen((String text) async {
        print('sub: $text');
    });
    
    stream.listen((int number) async {
        // any value returned by a computation will automatically be added back into the stream.
        return (number + number).toString(); // this will trigger the text listener.
    });
    
    stream.add('hello'); // output: sub: hello
    stream.add(2); // output: sub: 4
}
```

## Trigger Custom Events
You can subscribe to any type. *Note: a trigger should be immutable.*
``` Dart
class HelloWorld {
  final String message;
  HelloWorld(this.message);
}

stream.listen((HelloWorld helloWorld) async {
    print(helloWorld.message);
});

stream.add(HelloWorld('this is an example'));
```

## Multiple subscriptions of same type
You are not bound to listening to a trigger by just one listener
Any number of listeners of the same type can be created.
``` Dart
NeuralStream stream = NeuralStream();
    
stream.listen((String text) async {
    print('sub 1: $text');
});
stream.listen((String text) async {
    print('sub 2: $text');
});

stream.add('hello'); 
// output: sub 1: hello
// output: sub 2: hello
```

## Subscriptions are configurable
``` Dart
NeuralStream stream = NeuralStream();

stream.listen((String text) async {
    print('sub 1: $text');
}, max: 2); // limit this subscription to listen to a maximum of 2 events

stream.add('hello 1'); 
stream.add('hello 2'); 
stream.add('hello 3'); 

// output
// sub 1: hello 1
// sub 1: hello 2
```

## Cancel Subscriptions
``` Dart
NeuralStream stream = NeuralStream();

Subscription<String> subscription = stream.listen((String text) async {
    print('sub 1: $text');
});

stream.add('hello before subscription cancelled'); 
stream.cancel(subscription);
stream.add('hello after subscription cancelled'); 
// output: sub 1: hello before subscription cancelled
```

## Why Neural Stream?
A normal stream is bound to a specific type <T> which means that one needs many streams to support
different kinds of events. Super stream is not bound to a generic and can receive any object type

Another key difference of the super stream architecture is that it automatically passes the result 
of the reaction back into the stream which binds the reactions together without the user manually
having to connect them.


## Neurologically Oriented Programming
The inspiration for this architecture came from the brain. 

Our brain consists of a network of neurons. Signals travel through our brain from neuron to neuron
either activating it or not. 

If a neuron is activated it performs some kind of computation and can then produce a new signal
which will be once again passed to all the other neurons in the brain.

This structure is useful because the neuron doesn't have to know anything about the rest of the brain, it 
simply produces a signal and its job is finished. 



