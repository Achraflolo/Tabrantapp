import 'package:flutter/material.dart';
import '../models/app_models.dart';

class PostCard extends StatelessWidget {
  final CommunityPost post;
  final VoidCallback onLike;
  const PostCard({super.key, required this.post, required this.onLike});
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [const CircleAvatar(child: Icon(Icons.person_outline)), const SizedBox(width: 10), Expanded(child: Text(post.author, style: const TextStyle(fontWeight: FontWeight.bold))), Text(post.date, style: Theme.of(context).textTheme.bodySmall)]),
        const SizedBox(height: 12),
        Text(post.text),
        const SizedBox(height: 8),
        Row(children: [IconButton(onPressed: onLike, icon: Icon(post.liked ? Icons.favorite : Icons.favorite_border)), Text('${post.likes}'), const SizedBox(width: 14), const Icon(Icons.comment_outlined, size: 21), const SizedBox(width: 6), const Text('تعليق')]),
      ]),
    ),
  );
}
