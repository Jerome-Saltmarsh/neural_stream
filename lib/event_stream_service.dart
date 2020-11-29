library event_stream;

import 'event_streamer.dart';

abstract class EventStreamService {
  final EventStreamer stream;
  EventStreamService(this.stream);
}