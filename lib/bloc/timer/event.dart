abstract class TimerEvent {
  const TimerEvent();
}

class TimerTicked extends TimerEvent {
  const TimerTicked({required this.duration});
  final int duration;
}

class TimerStarted extends TimerEvent {}
class TimerPaused extends TimerEvent {}
class TimerResumed extends TimerEvent {}
class TimerReset extends TimerEvent {}