library event_stream;

import 'subscription.dart';

class SubscriptionException implements Exception {
  final Subscription subscription;
  final dynamic exception;
  final StackTrace stackTrace;
  final dynamic trigger;
  SubscriptionException(this.exception, this.subscription, this.stackTrace, this.trigger);

  @override
  String toString() {
    return 'SubscriptionException{subscription: $subscription, exception: $exception, stackTrace: $stackTrace, trigger: $trigger}';
  }
}
