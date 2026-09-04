import '../models/app_models.dart';

class AppStore {
  AppStore._();
  static final AppStore instance = AppStore._();

  final List<NewsItem> news = const [
    NewsItem(title: 'مرحباً بكم في تطبيق تبرانت', body: 'منصة رقمية تجمع أخبار القرية ومجتمعها وذاكرتها وخدماتها.', date: 'اليوم'),
    NewsItem(title: 'ذاكرة تبرانت', body: 'مساحة مستقبلية لحفظ الصور والقصص والشهادات المرتبطة بالقرية.', date: 'هذا الأسبوع'),
    NewsItem(title: 'إعلانات المجتمع', body: 'سيتم هنا نشر الإعلانات والمبادرات المحلية بعد مراجعتها.', date: 'هذا الأسبوع'),
  ];

  final List<CommunityPost> posts = [
    CommunityPost(author: 'أحد أبناء تبرانت', text: 'السلام عليكم، أهلاً بالجميع في منصة تبرانت الجديدة.', date: 'منذ قليل', likes: 8),
    CommunityPost(author: 'مجتمع تبرانت', text: 'يمكن استخدام هذا القسم للتواصل وطلب المساعدة ومشاركة الأخبار والمبادرات.', date: 'اليوم', likes: 5),
  ];

  final List<ServiceItem> services = const [
    ServiceItem(title: 'المحلات والمتاجر', subtitle: 'دليل الأنشطة التجارية المحلية', category: 'تجارة'),
    ServiceItem(title: 'الحرف والخدمات', subtitle: 'حرفيون ومهنيون من أبناء المنطقة', category: 'خدمات'),
    ServiceItem(title: 'النقل', subtitle: 'خدمات النقل المحلية', category: 'نقل'),
    ServiceItem(title: 'السكن والضيافة', subtitle: 'أماكن الإقامة والخدمات المرتبطة بها', category: 'ضيافة'),
  ];
}
