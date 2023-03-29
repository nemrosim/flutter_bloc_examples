import 'package:flutter/material.dart';

import '../../../bloc/posts/model.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '${post.id}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        post.title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      isThreeLine: false,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}
