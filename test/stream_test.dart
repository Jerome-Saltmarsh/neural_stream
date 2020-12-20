import 'package:neural_stream/subscription.dart';
import 'package:neural_stream/neural_stream.dart';
import 'package:test/test.dart';

void main() {

  test('hello world', () async {

    NeuralStream stream = NeuralStream();

    stream.listen((String text) async {
      print('sub: $text');
    });
    stream.listen((int number) async {
      // a value returned will be added back into the stream.
      return (number + number).toString(); // this will trigger the text listener.
    });

    stream.add('hello'); // output: sub: hello
    stream.add(2); // output: sub: 4
  });

  test('chain reactions', () async {

    NeuralStream stream = NeuralStream();

    stream.listen((int number) async {
      return (number + number).toString(); // this will trigger the text listener below.
    });

    stream.listen((String text) async {
      print('sub: $text');
    });

    stream.add('hello'); // output: sub: hello
    stream.add(2); // output: sub: 4
  });



  test('limited calls', () async {

    NeuralStream stream = NeuralStream();

    stream.listen((String text) async {
      print('sub 1: $text');
    }, max: 2);

    stream.add('hello 1'); // output: sub: hello
    stream.add('hello 2'); // output: sub: hello
    stream.add('hello 3'); // output: sub: hello
  });

  test('cancel subscription', () async {

    NeuralStream stream = NeuralStream();

    Subscription<String> subscription = stream.listen((String text) async {
      print('sub 1: $text');
    });

    stream.add('hello before subscription cancelled'); // output: sub: hello
    stream.cancel(subscription);
    stream.add('hello after subscription cancelled'); // output: sub: hello
  });


  test('Neural Stream Test', () async {

    NeuralStream stream = NeuralStream();
    stream.listen((String text) async => print(text));
    stream.listen((int number) async => int.parse('hello'));
    stream.listen((String text) async => print('sub 2: $text'), max: 1);
    stream.listen((Exception event) async {
      print(event);
    });

    Subscription<bool> boolSubscription = stream.listen((bool trigger) async {
      await Future.delayed(Duration(seconds: 1));
      return 12.5;
    });

    stream.add('hello world');
    stream.add(1);
    stream.add(10);
    stream.add(true);
    await Future.delayed(Duration(seconds: 1));
    print(boolSubscription);

  });
}
