import 'package:bluemark/Styles/app_style.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:bluemark/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import 'Admin/Screens/admin_screen.dart';
import 'Common/widgets/bottom_bar.dart';
import 'Features/auth/screens/customer_auth.dart';
import 'Seller/seller_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService authService = AuthService();

  @override
  void initState(){
    super.initState();
    authService.getUserData(context);

    Future.delayed(Duration(milliseconds: 1000), () {
      // Navigator.pushAndRemoveUntil(
      //     context,
          // MaterialPageRoute(
          //     builder: (_) => Provider.of<UserProvider>(context)
          //             .user
          //             .token
          //             .isNotEmpty
          //         ? Provider.of<UserProvider>(context).user.type == 'admin'
          //             ? AdminScreen()
          //             : Provider.of<UserProvider>(context).user.type == 'seller'
          //                 ? SellerScreen()
          //                 : BottomBar()
          //         : CustomerAuthScreen()), (route) => false);



      if(Provider.of<UserProvider>(context).user.token.isNotEmpty) {
        if(Provider.of<UserProvider>(context).user.type == 'admin') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>AdminScreen()));
        } else if(Provider.of<UserProvider>(context).user.type == 'seller') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SellerScreen()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>BottomBar()));
        }
        }
       else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>CustomerAuthScreen()));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
        title:
        user.type == 'plusmember' ?
        Text(
          "Welcome to ${appName} PLUS",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ):
        Text(
          "Welcome to ${appName}",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
              top: mq.height * .15,
              right: mq.width * .25,
              width: mq.width * .5,
              child: icon),
          Positioned(
              bottom: mq.height * .15,
              width: mq.width,
              child: Text(
                "Developed by AM Developers",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5),
              )),
        ],
      ),
    );
  }
}
