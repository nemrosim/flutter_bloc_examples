import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_examples/bloc/timer/bloc.dart';

import '../../bloc/timer/event.dart';
import '../../bloc/timer/state.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
        buildWhen: (prev, next) => prev != next,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Timer')),
            body: Center(
              child: Builder(builder: (context) {
                final duration =
                    context.select((TimerBloc bloc) => bloc.state.duration);

                return Text(
                  convertDurationToString(duration),
                  style: Theme.of(context).textTheme.displayMedium,
                );
              }),
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Builder(builder: (context) {
                  if (state.isInProgress && state.duration == 0) {
                    return const SizedBox.shrink();
                  }

                  IconData iconData = Icons.play_arrow;
                  void Function() func = () {
                    context.read<TimerBloc>().add(TimerStarted());
                  };

                  if (state.isInProgress) {
                    iconData = Icons.pause;
                    func = () {
                      context.read<TimerBloc>().add(TimerPaused());
                    };
                  }

                  if (!state.isInProgress &&
                      state.duration != defaultTimerDuration) {
                    iconData = Icons.pause;
                    func = () {
                      context.read<TimerBloc>().add(TimerResumed());
                    };
                  }

                  return FloatingActionButton(
                    onPressed: func,
                    child: Icon(iconData),
                  );
                }),
                const SizedBox(height: 20),
                Builder(builder: (context) {
                  if (!state.isInProgress &&
                      (state.duration == defaultTimerDuration ||
                          state.duration == 0)) {
                    return const SizedBox.shrink();
                  }

                  return FloatingActionButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(TimerReset()),
                    child: const Icon(Icons.replay),
                  );
                }),
              ],
            ),
          );
        });
  }
}

String convertDurationToString(int duration) {
  final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
  final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');

  return '$minutesStr:$secondsStr';
}
