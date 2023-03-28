import 'dart:async';
import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';
import 'timer_stream.dart';

const int defaultTimerDuration = 5;

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final TimerStream _timer;

  StreamSubscription<int>? _timerSubscription;

  TimerBloc({required TimerStream timer})
      : this._timer = timer,
        super(TimerState(duration: defaultTimerDuration, isInProgress: false)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
  }

  @override
  Future<void> close() {
    _timerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerState(duration: state.duration, isInProgress: true));

    _timerSubscription?.cancel();
    _timerSubscription = _timer
        .getStream(ticks: state.duration) // start stream
        .listen(
          // when value changes -> add TimerTicked event
          (value) => add(TimerTicked(duration: value)),
        );
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(TimerState(duration: event.duration, isInProgress: true));
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    _timerSubscription?.pause();
    emit(TimerState(duration: state.duration, isInProgress: false));
  }

  void _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    _timerSubscription?.resume();
    emit(TimerState(duration: state.duration, isInProgress: true));
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _timerSubscription?.cancel();

    emit(TimerState(duration: defaultTimerDuration, isInProgress: false));
  }
}
