library event_stream;

import 'event_stream_exception.dart';
import 'subscription.dart';

class Recording {
  final Subscription subscription;
  final dynamic input;
  final dynamic output;
  final DateTime started;
  final DateTime ended;
  final EventStreamException error;

  Recording({
    this.subscription,
    this.input,
    this.output,
    this.started,
    this.ended,
    this.error
  });
}
