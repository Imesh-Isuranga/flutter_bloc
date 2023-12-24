import 'dart:async';

class MyBloc {
  StreamController<MyState> _stateStreamController =
      StreamController<MyState>();

  StreamSink get _stateSink => _stateStreamController.sink;
  Stream<MyState> get stateStream => _stateStreamController.stream;

  StreamController<Event> _eventStreamController = StreamController<Event>();

  StreamSink get eventSink => _eventStreamController.sink;
  Stream<Event> get _eventStream => _eventStreamController.stream;

  MyBloc() {
    _eventStream.listen((event) {
      print(event);
      bussinessLogic(event);
      //_stateSink.add(event);
    });
  }

  void bussinessLogic(Event event) {
    // event++;
    int? value;
    if (event is IncrementEvent) {
      value = event.value;
      value++;
      _stateSink.add(IncrementState(value: value));
    } else if (event is DecrementEvent) {
      value = event.value;
      value--;
      _stateSink.add(DecrementState(value: value));
    }

    //_stateSink.add(value);
  }
}

abstract class Event {}

class IncrementEvent extends Event {
  int value;
  IncrementEvent({required this.value});
}

class DecrementEvent extends Event {
  int value;
  DecrementEvent({required this.value});
}

abstract class MyState {}

class IncrementState extends MyState {
  int value;
  IncrementState({required this.value});
}

class DecrementState extends MyState {
  int value;
  DecrementState({required this.value});
}
