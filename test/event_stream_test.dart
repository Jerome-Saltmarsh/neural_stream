import 'package:flutter_test/flutter_test.dart';

import 'package:event_stream/event_stream.dart';

void main() {

  test('Event Stream Test', () {

    EventStream stream = EventStream();

    stream.subscribe((String text) async {
      print('sub 1: $text');
    }, description: "Prints the message given", maxCalls: 3);

    stream.subscribe((String text) async {
      print("sub 2: $text");
    }, description: "Prints the message given", maxCalls: 1);

    stream.subscribe((SendEmail sendEmail) async {
      print('sending email message: ${sendEmail.message}');
    });

    stream.add('hello world 1');
    stream.add('hello world 2');
    stream.add('hello world 3');
    stream.add('hello world 4');
    stream.add(SendEmail("Demo"));
  });
}


class SendEmail {
  final String message;
  SendEmail(this.message);
}
