import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/counter_cubit.dart';
import 'bloc/counter_observer.dart';
import 'pages/Counter/counter.dart';

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
      home: BlocProvider(
        create: (BuildContext context) => CounterCubit(),
        child: const CounterPage(),
      ),
    );
  }
}
