import 'model.dart';

enum PostStatus { initial, success, failure, loading }

class PostsState {
  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;

  const PostsState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  PostsState.cloneWithOverride(PostsState prevState, {
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
  })
      : this(
            status: status ?? prevState.status,
            posts: posts ?? prevState.posts,
            hasReachedMax: hasReachedMax ?? prevState.hasReachedMax);

  @override
  String toString() {
    return 'PostsState{status: $status, posts: $posts, hasReachedMax: $hasReachedMax}';
  }
}
