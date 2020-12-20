library event_stream;

import 'reaction.dart';
import 'call.dart';

/// A Neuron
class Subscription<T> {
  // injected
  final String description;
  final Reaction<T> function;
  final int maxCalls;
  final List<Call> calls = [];

  bool enabled;
  int _totalCalls = 0;

  int get callCount => _totalCalls;
  int get totalErrors => calls.where((call) => call.error != null).length;
  Type get type => T;

  Subscription({
    this.function,
    this.description,
    this.maxCalls,
    this.enabled = true,
  });

  Future handle(var value) async {
    _totalCalls++;
    return await function(value);
  }

  bool canHandle(var value) {

    if (maxCalls != null && _totalCalls >= maxCalls) return false;

    return enabled && value is T;
  }

  @override
  String toString() {
    return 'Subscription{description: $description, function: $function, maxCalls: $maxCalls, enabled: $enabled, _calls: $_totalCalls}';
  }
}