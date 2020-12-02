library event_stream;

import 'reaction.dart';
import 'memory.dart';

/// A Neuron
class Subscription<T> {
  // injected
  final String description;
  final Reaction<T> function;
  final int maxCalls;
  final List<Memory> memories = [];

  // variables
  bool enabled;
  // private
  int _calls = 0;
  bool remember;

  Subscription({
    this.function,
    this.description,
    this.maxCalls,
    this.remember = true,
    this.enabled = true,
  });

  Future handle(var value) async {
    _calls++;
    return await function(value);
  }

  bool canHandle(var value) {

    if (maxCalls != null && _calls >= maxCalls) return false;

    return enabled && value is T;
  }

  @override
  String toString() {
    return 'Subscription{description: $description, function: $function, maxCalls: $maxCalls, enabled: $enabled, _calls: $_calls, remember: $remember}';
  }
}