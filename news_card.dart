import 'package:flutter/material.dart';
import '../models/app_models.dart';

class NewsCard extends StatelessWidget {
  final NewsItem item;
  final VoidCallback? onTap;
  const NewsCard({super.key, required this.item, this.onTap});
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.all(14),
      leading: CircleAvatar(child: const Icon(Icons.article_outlined)),
      title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Padding(padding: const EdgeInsets.only(top: 6), child: Text('${item.body}\n${item.date}')),
      isThreeLine: true,
      trailing: const Icon(Icons.chevron_left),
    ),
  );
}
