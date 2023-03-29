import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_examples/bloc/posts/state.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(const PostsState());

  void fetchPosts() async {
    if (state.hasReachedMax) return;
    try {
      emit(PostsState.cloneWithOverride(state, status: PostStatus.loading));

      if (state.status == PostStatus.initial) {
        print('INITIAL');
        final posts = await _fetchPosts();

        emit(PostsState(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      } else {
        final posts = await _fetchPosts(startIndex: state.posts.length);

        final newState = posts.isEmpty
            ? PostsState.cloneWithOverride(state, hasReachedMax: true)
            : PostsState(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              );

        emit(newState);
      }
    } catch (_) {
      emit(PostsState.cloneWithOverride(state, status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts({int startIndex = 0}) async {
    final uri = Uri(
        scheme: 'https',
        host: 'jsonplaceholder.typicode.com',
        path: '/posts',
        queryParameters: {'_start': '$startIndex', '_limit': '20'});

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('error fetching posts');
    }

    final List<dynamic> body = json.decode(response.body);

    return convertJsonToPostList(body);
  }

  List<Post> convertJsonToPostList(List list) {
    Iterable<Post> iterable = list.map((json) {
      final map = json as Map<String, dynamic>;
      return Post(
        id: map['id'] as int,
        title: map['title'] as String,
        body: map['body'] as String,
      );
    });

    return iterable.toList();
  }
}
