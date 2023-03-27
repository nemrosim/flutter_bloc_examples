import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_examples/bloc/timer/bloc.dart';

import '../../bloc/timer/event.dart';
import '../../bloc/timer/state.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {




  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Timer')),
            body: Center(
              child: Builder(builder: (context) {
                final duration =
                    context.select((TimerBloc bloc) => bloc.state.duration);

                final minutesStr =
                    ((duration / 60) % 60).floor().toString().padLeft(2, '0');
                final secondsStr =
                    (duration % 60).floor().toString().padLeft(2, '0');

                return Text(
                  '$minutesStr:$secondsStr',
                  style: Theme.of(context).textTheme.displayMedium,
                );
              }),
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () => context
              .read<TimerBloc>()
              .add(TimerStarted(duration: state.duration)),
                ),
                const SizedBox(height: 20),
                FloatingActionButton(
                  child: const Icon(Icons.pause),
                  onPressed: () {},
                ),
              ],
            ),
          );
        });
  }
}
