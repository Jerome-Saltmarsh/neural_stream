library event_stream;

import 'subscription_exception.dart';
import 'memory.dart';
import 'reaction.dart';
import 'subscription.dart';

class NeuralStream {

  final String name;
  List<Subscription> _subscriptions = [];

  NeuralStream({this.name});

  void add<T>(T trigger) {
    if (trigger == null) return;

    _subscriptions
        .where((subscription) => subscription.canHandle(trigger))
        .forEach((subscription) {

      SubscriptionException subscriptionException;
      DateTime started = DateTime.now();

      Future futureResult =
          subscription.handle(trigger).catchError((error, stacktrace) {
        subscriptionException = SubscriptionException(error, subscription, stacktrace, trigger);
        add(subscriptionException);
        return null;
      });

      futureResult.then((output) {
        if (subscription.remember) {
          Memory recording = Memory(
              input: trigger,
              output: output,
              error: subscriptionException,
              started: started,
              ended: DateTime.now());
          subscription.memories.add(recording);
        }

        if (output == null) return;

        if (output is CancelSubscription) {
          cancel(subscription);
          return;
        }

        add(output);
      });
    });
  }

  Subscription<T> listen<T>(Reaction<T> function,
      {String description, bool enabled = true, int max}) {

    final Subscription subscription = Subscription<T>(
        function: function,
        description: description,
        enabled: enabled,
        maxCalls: max);
    _subscriptions.add(subscription);
    return subscription;
  }

  void cancel(Subscription subscription) {
    _subscriptions.remove(subscription);
  }
}

class CancelSubscription {
  final Subscription subscription;

  CancelSubscription(this.subscription);
}
