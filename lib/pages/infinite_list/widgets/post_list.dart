import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/posts/cubit.dart';
import '../../../bloc/posts/state.dart';
import 'post_list_item.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      if(context.read<PostsCubit>().state.status != PostStatus.loading) {
        context.read<PostsCubit>().fetchPosts();
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {

        if(state.status == PostStatus.loading && state.posts.isEmpty){
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index >= state.posts.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(strokeWidth: 2.5,)),
                ),
              );
            } else {
              return PostListItem(post: state.posts[index]);
            }
          },
          itemCount:
              state.hasReachedMax ? state.posts.length : state.posts.length + 1,
          controller: _scrollController,
        );
      },
    );
  }
}
