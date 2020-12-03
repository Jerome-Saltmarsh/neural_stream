library event_stream;

import 'subscription_exception.dart';

class Call {
  final dynamic input;
  final dynamic output;
  final DateTime started;
  final DateTime ended;
  final SubscriptionException error;

  Call({
    this.input,
    this.output,
    this.started,
    this.ended,
    this.error
  });
}

extension CallExtensions on Call {
  Duration get duration => started.difference(ended);
  bool get hasError => error != null;
}