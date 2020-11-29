# event_stream

An utility for reactive programming

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

class DoSomething { }

stream.subscribe((HelloWorld helloWorld) async {
    // business logic goes here
    print(helloWorld.message);
});

stream.subscribe((DoSomething doSomething) async {
    // business logic goes here
    print('do something event received');   
});

stream.add(HelloWorld('testing'));
stream.add(DoSomething());
```
