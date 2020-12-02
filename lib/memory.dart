library event_stream;

import 'subscription_exception.dart';

class Memory {
  final dynamic input;
  final dynamic output;
  final DateTime started;
  final DateTime ended;
  final SubscriptionException error;

  Memory({
    this.input,
    this.output,
    this.started,
    this.ended,
    this.error
  });
}

extension MemoryExtensions on Memory {
  Duration get duration => started.difference(ended);
}