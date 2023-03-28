import 'dart:async';
import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';
import 'timer_stream.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final TimerStream _timer;
  static const int _duration = 5;

  StreamSubscription<int>? _timerSubscription;

  TimerBloc({required TimerStream timer})
      : this._timer = timer,
        super(const TimerState(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
  }

  @override
  Future<void> close() {
    _timerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {

    emit(TimerState(event.duration));

    _timerSubscription?.cancel();
    _timerSubscription = _timer
        .getStream(ticks: event.duration) // start stream
        .listen(
          // when value changes -> add TimerTicked event
          (duration) => add(TimerTicked(duration: duration)),
        );
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(TimerState(event.duration));
  }
}
