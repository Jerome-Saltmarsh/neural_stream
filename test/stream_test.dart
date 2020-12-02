import 'package:neural_stream/subscription.dart';
import 'package:neural_stream/neural_stream.dart';
import 'package:test/test.dart';

void main() {
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
