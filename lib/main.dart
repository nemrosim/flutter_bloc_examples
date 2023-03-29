import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_examples/bloc/counter/bloc/counter_bloc.dart';
import 'package:flutter_bloc_examples/bloc/timer/bloc.dart';
import 'package:flutter_bloc_examples/pages/counter/counter_bloc.dart';
import 'package:flutter_bloc_examples/pages/counter/counter_cubit.dart';
import 'package:flutter_bloc_examples/pages/timer/timer.dart';
import 'bloc/counter/cubit/counter_cubit.dart';
import 'bloc/counter/cubit/counter_observer.dart';
import 'bloc/posts/cubit.dart';
import 'bloc/timer/timer_stream.dart';
import 'pages/infinite_list/infinite_list.dart';

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
          BlocProvider(
            create: (BuildContext context) => CounterBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => TimerBloc(
              timer: const TimerStream(),
            ),
          ),
          BlocProvider(
            // create: (BuildContext context) => PostsCubit()..fetchPosts();
            create: (BuildContext context) {
              final postCubit = PostsCubit();
              postCubit.fetchPosts();
              return postCubit;
            },
          ),
        ],
        child: const InfiniteListPage(),
      ),
    );
  }
}
