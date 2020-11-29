library event_stream;

import 'event_stream.dart';
import 'reaction.dart';

class Subscription<T> {

  final String description;
  final EventStream stream;
  final Reaction<T> function;
  bool enabled = true;
  int maxCalls;
  int _calls = 0;

  Subscription({this.stream, this.function, this.enabled, this.description, this.maxCalls});

  Future handle(var value) async {
    _calls++;
    return await function(value);
  }

  bool canHandle(var value) {

    if (maxCalls != null && _calls >= maxCalls) return false;

    return enabled && value is T;
  }

  void cancel(){
    stream.cancel(this);
  }
}