library event_stream;

import 'event_stream_exception.dart';
import 'event_streamer.dart';
import 'recording.dart';
import 'reaction.dart';
import 'subscription.dart';

class EventStream extends EventStreamer {
  List<Subscription> _subscriptions = [];

  @override
  void add<T>(T trigger) {

    if (trigger == null) return;

    _subscriptions
        .where((subscription) => subscription.canHandle(trigger))
        .forEach((subscription) {
      EventStreamException eventStreamException;

      DateTime started = DateTime.now();

      Future futureResult = subscription.handle(trigger).catchError((error, stacktrace) {
        eventStreamException = EventStreamException(error, stacktrace, trigger);
        add(eventStreamException);
        return null;
      });

      futureResult.then((output) {
        add(Recording(
            subscription: subscription,
            input: trigger,
            output: output,
            error: eventStreamException,
            started: started,
            ended: DateTime.now()));

        if (output == null) return;

        if (output is CancelSubscription) {
          cancel(subscription);
          return;
        }

        add(output);
      });
    });
  }

  @override
  Subscription subscribe<T>(Reaction<T> function,
      {String description, bool enabled = true, int maxCalls}) {

    final Subscription subscription = Subscription<T>(
        stream: this,
        function: function,
        description: description,
        enabled: enabled,
        maxCalls: maxCalls
    );
    _subscriptions.add(subscription);
    return subscription;
  }

  @override
  void cancel(Subscription subscription) {
    _subscriptions.remove(subscription);
  }
}

class CancelSubscription {
  final Subscription subscription;

  CancelSubscription(this.subscription);
}
