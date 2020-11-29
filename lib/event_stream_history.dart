library event_stream;

import 'event_stream_service.dart';
import 'event_streamer.dart';
import 'recording.dart';

class EventStreamHistory extends EventStreamService {

  // variables
  List<Recording> recordings = [];

  EventStreamHistory(EventStreamer stream) : super(stream) {
    stream.subscribe(add);
  }

  void add(Recording event) async {
    recordings.add(event);
  }
}