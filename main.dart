import 'package:flutter/material.dart';
import 'models/app_models.dart';
import 'services/app_store.dart';
import 'widgets/news_card.dart';
import 'widgets/post_card.dart';
import 'widgets/section_title.dart';

void main() => runApp(const TabranteApp());

class TabranteApp extends StatefulWidget {
  const TabranteApp({super.key});
  @override State<TabranteApp> createState() => _TabranteAppState();
}

class _TabranteAppState extends State<TabranteApp> {
  ThemeMode mode = ThemeMode.light;
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'تبرانت | Tabrante',
    themeMode: mode,
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal, scaffoldBackgroundColor: const Color(0xfff7f8f7), inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder())),
    darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark, colorSchemeSeed: Colors.teal, inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder())),
    home: WelcomeScreen(onToggleTheme: () => setState(() => mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light)),
  );
}

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  const WelcomeScreen({super.key, required this.onToggleTheme});
  @override
  Widget build(BuildContext context) => Scaffold(body: SafeArea(child: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    CircleAvatar(radius: 62, backgroundColor: Theme.of(context).colorScheme.primaryContainer, child: Text('ⵣ', style: TextStyle(fontSize: 60, color: Theme.of(context).colorScheme.primary))),
    const SizedBox(height: 20), const Text('تبرانت', style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold)), const Text('Tabrante', style: TextStyle(fontSize: 20)),
    const SizedBox(height: 10), const Text('أخبارنا • مجتمعنا • ذاكرتنا • خدماتنا', textAlign: TextAlign.center), const SizedBox(height: 36),
    SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())), icon: const Icon(Icons.login), label: const Text('الدخول إلى التطبيق'))),
    const SizedBox(height: 12), SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen(register: true))), icon: const Icon(Icons.person_add_alt_1), label: const Text('إنشاء حساب'))),
    const SizedBox(height: 14), TextButton.icon(onPressed: onToggleTheme, icon: const Icon(Icons.dark_mode_outlined), label: const Text('تغيير المظهر')),
    const SizedBox(height: 24), const Text('نسخة مجتمعية أولية قابلة للتطوير', style: TextStyle(fontSize: 12)),
  ]))));
}

class LoginScreen extends StatefulWidget {
  final bool register;
  const LoginScreen({super.key, this.register = false});
  @override State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController(); final password = TextEditingController(); final name = TextEditingController();
  bool busy = false;
  @override void dispose(){email.dispose(); password.dispose(); name.dispose(); super.dispose();}
  void submit(){if(!(formKey.currentState?.validate() ?? false)) return; setState(()=>busy=true); Future.delayed(const Duration(milliseconds:400),(){if(!mounted)return; Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>HomeScreen(displayName: widget.register ? name.text.trim() : 'زائر تبرانت')), (_)=>false);});}
  @override Widget build(BuildContext context)=>Scaffold(appBar: AppBar(title: Text(widget.register?'إنشاء حساب':'تسجيل الدخول')), body: Form(key: formKey, child: ListView(padding: const EdgeInsets.all(22), children:[
    if(widget.register)...[TextFormField(controller:name, decoration:const InputDecoration(labelText:'الاسم', prefixIcon:Icon(Icons.person_outline)), validator:(v)=>v==null||v.trim().isEmpty?'أدخل الاسم':null), const SizedBox(height:14)],
    TextFormField(controller:email, keyboardType:TextInputType.emailAddress, decoration:const InputDecoration(labelText:'البريد الإلكتروني', prefixIcon:Icon(Icons.email_outlined)), validator:(v)=>v==null||!v.contains('@')?'أدخل بريداً صحيحاً':null), const SizedBox(height:14),
    TextFormField(controller:password, obscureText:true, decoration:const InputDecoration(labelText:'كلمة المرور', prefixIcon:Icon(Icons.lock_outline)), validator:(v)=>v==null||v.length<4?'كلمة المرور قصيرة':null), const SizedBox(height:24),
    SizedBox(width:double.infinity, child:FilledButton(onPressed:busy?null:submit, child:Text(busy?'جاري الدخول...':widget.register?'إنشاء الحساب':'دخول'))), const SizedBox(height:12),
    const Text('هذه النسخة تحفظ البيانات داخل الجلسة فقط. يمكن لاحقاً ربط Firebase أو خادم خاص.', textAlign:TextAlign.center),
  ]));
}

class HomeScreen extends StatefulWidget {
  final String displayName;
  const HomeScreen({super.key, required this.displayName});
  @override State<HomeScreen> createState()=>_HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{int index=0;
  late final pages=<Widget>[HomePage(onNavigate:(i)=>setState(()=>index=i)), const NewsPage(), CommunityPage(onChanged:()=>setState((){})), const ServicesPage(), ProfilePage(displayName:widget.displayName, onLogout:()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(_)=>const WelcomeScreen(onToggleTheme:_noop)), (_)=>false))];
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('تبرانت | Tabrante',style:TextStyle(fontWeight:FontWeight.bold)),actions:[IconButton(onPressed:()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('لا توجد إشعارات جديدة'))),icon:const Icon(Icons.notifications_none))]),body:pages[index],bottomNavigationBar:NavigationBar(selectedIndex:index,onDestinationSelected:(v)=>setState(()=>index=v),destinations:const[
    NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:'الرئيسية'),NavigationDestination(icon:Icon(Icons.newspaper_outlined),selectedIcon:Icon(Icons.newspaper),label:'الأخبار'),NavigationDestination(icon:Icon(Icons.groups_outlined),selectedIcon:Icon(Icons.groups),label:'المجتمع'),NavigationDestination(icon:Icon(Icons.storefront_outlined),selectedIcon:Icon(Icons.storefront),label:'الخدمات'),NavigationDestination(icon:Icon(Icons.person_outline),selectedIcon:Icon(Icons.person),label:'حسابي') ]));}

class HomePage extends StatelessWidget { final ValueChanged<int> onNavigate; const HomePage({super.key,required this.onNavigate});
 @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[Card(child:Padding(padding:const EdgeInsets.all(20),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('مرحباً بك في تبرانت 👋',style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.bold)),const SizedBox(height:8),const Text('منصة مجتمعية للحفاظ على الذاكرة، مشاركة الأخبار، وتسهيل الوصول إلى الخدمات المحلية.')]))),const SizedBox(height:14),GridView.count(crossAxisCount:2,shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),crossAxisSpacing:10,mainAxisSpacing:10,children:[_FeatureTile(icon:Icons.map,title:'خريطة تبرانت',onTap:()=>_info(context,'الخريطة ستعرض المعالم والخدمات عند إضافة البيانات.')), _FeatureTile(icon:Icons.photo_library_outlined,title:'ذاكرة تبرانت',onTap:()=>_info(context,'قسم مخصص للصور والقصص والشهادات المحلية.')), _FeatureTile(icon:Icons.report_problem_outlined,title:'بلاغ جديد',onTap:()=>_showReport(context)), _FeatureTile(icon:Icons.event_outlined,title:'المناسبات',onTap:()=>_info(context,'هنا ستظهر المناسبات والأنشطة المحلية.'))]),const SizedBox(height:18),SectionTitle(title:'آخر الأخبار',action:'كل الأخبار',onAction:()=>onNavigate(1)),...AppStore.instance.news.take(2).map((n)=>NewsCard(item:n))]); }
}
class _FeatureTile extends StatelessWidget{final IconData icon;final String title;final VoidCallback onTap;const _FeatureTile({required this.icon,required this.title,required this.onTap});@override Widget build(BuildContext context)=>Card(child:InkWell(onTap:onTap,borderRadius:BorderRadius.circular(12),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(icon,size:38),const SizedBox(height:8),Text(title,textAlign:TextAlign.center,style:const TextStyle(fontWeight:FontWeight.w600))])));}

class NewsPage extends StatelessWidget{const NewsPage({super.key});@override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[const SectionTitle(title:'أخبار وإعلانات تبرانت'),const SizedBox(height:4),...AppStore.instance.news.map((n)=>NewsCard(item:n,onTap:()=>showDialog(context:context,builder:(_)=>AlertDialog(title:Text(n.title),content:Text(n.body),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('إغلاق'))]))) ]);}

class CommunityPage extends StatefulWidget{final VoidCallback onChanged;const CommunityPage({super.key,required this.onChanged});@override State<CommunityPage> createState()=>_CommunityPageState();}
class _CommunityPageState extends State<CommunityPage>{final controller=TextEditingController();void add(){final text=controller.text.trim();if(text.isEmpty)return;setState(()=>AppStore.instance.posts.insert(0,CommunityPost(author:'أنا',text:text,date:'الآن')));controller.clear();widget.onChanged();Navigator.pop(context);}
void compose(){showModalBottomSheet(context:context,isScrollControlled:true,builder:(c)=>Padding(padding:EdgeInsets.only(left:16,right:16,top:16,bottom:MediaQuery.of(c).viewInsets.bottom+16),child:Column(mainAxisSize:MainAxisSize.min,children:[const Text('منشور جديد',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),const SizedBox(height:12),TextField(controller:controller,maxLines:4,decoration:const InputDecoration(hintText:'اكتب رسالتك للمجتمع...')),const SizedBox(height:12),SizedBox(width:double.infinity,child:FilledButton(onPressed:add,child:const Text('نشر')))])));}
@override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[Row(children:[const Expanded(child:SectionTitle(title:'مجتمع تبرانت')),FloatingActionButton.small(onPressed:compose,child:const Icon(Icons.add))]),const SizedBox(height:8),...AppStore.instance.posts.map((p)=>PostCard(post:p,onLike:(){setState(()=>p.liked=!p.liked);p.likes += p.liked?1:-1;widget.onChanged();}))]);}

class ServicesPage extends StatelessWidget{const ServicesPage({super.key});@override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[const SectionTitle(title:'خدمات تبرانت'),const SizedBox(height:6),...AppStore.instance.services.map((s)=>Card(child:ListTile(leading:CircleAvatar(child:Icon(s.category=='نقل'?Icons.directions_car_outlined:s.category=='تجارة'?Icons.store_outlined:s.category=='ضيافة'?Icons.hotel_outlined:Icons.handyman_outlined)),title:Text(s.title),subtitle:Text(s.subtitle),trailing:const Icon(Icons.chevron_left),onTap:()=>_info(context,'سيتم لاحقاً إضافة تفاصيل الاتصال والموقع والخدمات.'))))]);}

class ProfilePage extends StatelessWidget{final String displayName;final VoidCallback onLogout;const ProfilePage({super.key,required this.displayName,required this.onLogout});@override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[const CircleAvatar(radius:45,child:Icon(Icons.person,size:45)),const SizedBox(height:12),Center(child:Text(displayName.isEmpty?'حسابي':displayName,style:const TextStyle(fontSize:24,fontWeight:FontWeight.bold))),const SizedBox(height:18),Card(child:ListTile(leading:const Icon(Icons.language),title:const Text('اللغة'),subtitle:const Text('العربية • الريفية • الفرنسية'),onTap:()=>_info(context,'إعداد اللغة سيصبح متعدد اللغات في الإصدار القادم.'))),Card(child:ListTile(leading:const Icon(Icons.settings_outlined),title:const Text('الإعدادات'),onTap:()=>_info(context,'الإعدادات الأساسية جاهزة للتوسعة.'))),Card(child:ListTile(leading:const Icon(Icons.admin_panel_settings_outlined),title:const Text('لوحة الإدارة'),subtitle:const Text('للمشرفين فقط'),onTap:()=>_info(context,'ستحتاج لوحة الإدارة إلى نظام صلاحيات وقاعدة بيانات.'))),Card(child:ListTile(leading:const Icon(Icons.info_outline),title:const Text('عن التطبيق'),subtitle:const Text('تبرانت 1.0.0'))),Card(child:ListTile(leading:const Icon(Icons.logout),title:const Text('تسجيل الخروج'),onTap:onLogout))]);}

void _info(BuildContext context,String message)=>showDialog(context:context,builder:(_)=>AlertDialog(content:Text(message),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('حسناً'))]));
void _showReport(BuildContext context){final c=TextEditingController();showDialog(context:context,builder:(_)=>AlertDialog(title:const Text('بلاغ جديد'),content:TextField(controller:c,maxLines:4,decoration:const InputDecoration(hintText:'صف المشكلة أو البلاغ...')),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('إلغاء')),FilledButton(onPressed:(){Navigator.pop(context);ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('تم حفظ البلاغ في النسخة التجريبية.')));},child:const Text('إرسال'))]));}
void _noop(){}
