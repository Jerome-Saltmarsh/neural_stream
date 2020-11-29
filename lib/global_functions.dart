library event_stream;

import 'reaction.dart';
import 'global_instance.dart';

void add<T>(T message) {
  eventStream.add(message);
}

void subscribe<T>(Reaction<T> messageFunction) {
  eventStream.subscribe(messageFunction);
}