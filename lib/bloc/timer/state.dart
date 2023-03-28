class TimerState {
  final int duration;
  final bool isInProgress;

  TimerState({required this.duration, required this.isInProgress});

  @override
  String toString() {
    return 'TimerState{duration: $duration}';
  }
}
