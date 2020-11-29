library event_stream;

import 'reaction.dart';
import 'subscription.dart';

abstract class EventStreamer {
  void add<T>(T trigger);
  Subscription subscribe<T>(Reaction<T> reaction);
  void cancel(Subscription subscription);
}

