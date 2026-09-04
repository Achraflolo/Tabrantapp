class NewsItem {
  final String title;
  final String body;
  final String date;
  const NewsItem({required this.title, required this.body, required this.date});
}

class CommunityPost {
  final String author;
  final String text;
  final String date;
  int likes;
  bool liked;
  CommunityPost({required this.author, required this.text, required this.date, this.likes = 0, this.liked = false});
}

class ServiceItem {
  final String title;
  final String subtitle;
  final String category;
  const ServiceItem({required this.title, required this.subtitle, required this.category});
}
