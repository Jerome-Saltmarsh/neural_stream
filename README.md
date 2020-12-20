# Neural Stream
Neural stream is a library designed to simplify reactive programming.

It provides an interface exactly like a normal stream to make it easy to pickup for anyone already 
familiar with streams however with several key differences.

1. **Not Type Bound** Unlike a regular stream a neural stream is not bound to a specific type <T>. 
Instead anything can be added to the stream and only a single stream is required to handle all 
events.

2. **Automatic Event Chaining**
If a stream's listener function returns a value, that value will automatically be fed back into the 
stream. This provides a mechanism for chaining reactions together without the listener function 
itself having to be aware of the stream. The same occurs to any exceptions thrown inside listener 
function

## Hello World
``` Dart
import 'package:event_stream/event_stream.dart';

void main() {

    NeuralStream stream = NeuralStream();
    
    stream.listen((String text) async {
        print('sub: $text');
    });
    
    stream.add('hello world'); // output: 'sub: hello world'
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

## Chain Reactions
``` Dart
NeuralStream stream = NeuralStream();

stream.listen((int number) async {
    return (number + number).toString(); // this will trigger the text listener below.
});

stream.listen((String text) async {
    print('sub: $text');
});

stream.add('hello'); // output: sub: hello
stream.add(2); // output: sub: 4
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

## Neurologically Oriented Programming
The inspiration for this architecture came from the brain. 

Our brain consists of a network of neurons. Signals travel through our brain from neuron to neuron
either activating it or not. 

If a neuron is activated it performs some kind of computation and can then produce a new signal
which will be once again passed to all the other neurons in the brain.

This structure is useful because the neuron doesn't have to know anything about the rest of the brain, it 
simply produces a signal and its job is finished. 



