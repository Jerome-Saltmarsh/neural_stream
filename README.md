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
``` Dart
class HelloWorld {
  final String message;
  HelloWorld(this.message);
}

stream.subscribe((HelloWorld helloWorld) async {
    // business logic goes here
    print(helloWorld.message);
});

stream.add(HelloWorld('testing'));
```
