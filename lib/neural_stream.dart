library event_stream;

import 'subscription_exception.dart';
import 'call.dart';
import 'reaction.dart';
import 'subscription.dart';


class NeuralStream {

  final String name;
  List<Subscription> subscriptions = [];

  NeuralStream({this.name});

  void add<T>(T trigger) {
    if (trigger == null) return;

    subscriptions
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
          Call call = Call(
              input: trigger,
              output: output,
              error: subscriptionException,
              started: started,
              ended: DateTime.now());
          subscription.calls.add(call);
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
    subscriptions.add(subscription);
    return subscription;
  }

  void cancel(Subscription subscription) {
    subscriptions.remove(subscription);
  }
}

/// This is used to cancel a subscription from within a computation
/// if the computation returns this object its subscription will be cancelled
class CancelSubscription {
  final Subscription subscription;

  CancelSubscription(this.subscription);
}
