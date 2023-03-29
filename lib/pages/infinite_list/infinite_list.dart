import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_examples/bloc/posts/cubit.dart';
import 'package:flutter_bloc_examples/bloc/posts/state.dart';

import 'widgets/post_list.dart';

class InfiniteListPage extends StatelessWidget {
  const InfiniteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Infinite list')),
      body: Center(
        child: BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {

          if(state.status == PostStatus.initial){
            return const Center(child: Text('This should not happen'));
          }

          return const PostList();

        }),
      ),
    );
  }
}
