import 'package:bluemark/Admin/Screens/admin_screen.dart';
import 'package:bluemark/Common/widgets/bottom_bar.dart';
import 'package:bluemark/Seller/seller_screen.dart';
import 'package:bluemark/Styles/app_style.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:bluemark/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Features/auth/screens/customer_auth.dart';

late Size mq;
final String appName = "BLUE MARK";
final Image icon = Image.asset('images/icon.png');
final Image appbaricon = Image.asset('images/appbaricon.png', width: mq.width*.15,height: mq.height*.15,);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState(){
    super.initState();
    authService.getUserData(context);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blue Mark',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: AppStyle.mainColor),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff000633)),
        iconTheme: IconThemeData(color: Colors.white),
        useMaterial3: true,
      ),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty ? Provider.of<UserProvider>(context).user.type == 'admin'? AdminScreen() : Provider.of<UserProvider>(context).user.type == 'seller' ? SellerScreen() : BottomBar() : CustomerAuthScreen(),
      // home: SplashScreen(),
    );
  }
}
