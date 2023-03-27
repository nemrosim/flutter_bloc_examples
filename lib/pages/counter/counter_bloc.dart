import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/counter/cubit/counter_cubit.dart';

class CounterBlocPage extends StatelessWidget {
  const CounterBlocPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) => Text(
            '$state',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterCubit>().increment(),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
          ),
        ],
      ),
    );
  }
}
