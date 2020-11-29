library event_stream;

class EventStreamException {
  final dynamic exception;
  final StackTrace stackTrace;
  final dynamic event;
  EventStreamException(this.exception, this.stackTrace, this.event);
}
