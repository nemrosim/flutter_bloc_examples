import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timer')),
      body: Center(
        child: Text(
          'Something',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.play_arrow),
            onPressed: () {},
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            child: const Icon(Icons.pause),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
