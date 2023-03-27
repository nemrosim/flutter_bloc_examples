import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_examples/pages/timer/timer.dart';
import 'bloc/counter/cubit/counter_cubit.dart';
import 'bloc/counter/cubit/counter_observer.dart';

void main() {
  Bloc.observer = const CounterObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => CounterCubit(),
          ),
        ],
        child: const TimerPage(),
      ),
    );
  }
}
