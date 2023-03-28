abstract class TimerEvent {
  const TimerEvent();
}

class TimerStarted extends TimerEvent {
  const TimerStarted({required this.duration});
  final int duration;
}

class TimerTicked extends TimerEvent {
  const TimerTicked({required this.duration});
  final int duration;
}