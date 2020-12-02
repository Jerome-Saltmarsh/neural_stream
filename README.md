# Neural Stream
A library for neurologically oriented programming

## Getting Started

``` Dart
import 'package:event_stream/event_stream.dart';

void main() {

    EventStream stream = EventStream();

    stream.subscribe((String text) async {
        print('subscription: $text');
    });

    stream.add('hello world');
}
```

## Custom Events
You can subscribe to as many different types as you want.
Note that a trigger should be immutable

``` Dart
class HelloWorld {
  final String message;
  HelloWorld(this.message);
}

stream.subscribe((HelloWorld helloWorld) async {
    print(helloWorld.message);
});

stream.add(HelloWorld('this is an example'));
```

## Why Super Stream?
A normal stream is bound to a specific type <T> which means that one needs many streams to support
different kinds of events. Super stream is not bound to a generic and can receive any object type

Another key difference of the super stream architecture is that it automatically passes the result 
of the reaction back into the stream which binds the reactions together without the user manually
having to connect them.


## Neurologically Oriented Programming
I took the inspiration for this architecture from the brain. 

Each subscription represents a neuron. When a signal is passed through the brain a neuron is either
activated or not, when it is activated it does some computation and then can produce a new signal
which will be once again passed to all the other neurons in the brain via synapses.

This is useful because the neuron doesn't have to know anything about the rest of the brain, it 
simply produces a signal and its job is finished.



