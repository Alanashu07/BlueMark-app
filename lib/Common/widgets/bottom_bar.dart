import 'package:bluemark/Features/AboutUs/about_us.dart';
import 'package:bluemark/Features/cart/screens/cart_screen.dart';
import 'package:bluemark/Pages/account/screens/account_screen.dart';
import 'package:bluemark/Pages/account/services/account_services.dart';
import 'package:bluemark/Pages/homescreen/Services/home_services.dart';
import 'package:bluemark/Pages/homescreen/home_screen.dart';
import 'package:bluemark/Styles/app_style.dart';
import 'package:bluemark/constants/global_variables.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../../main.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final AccountServices accountServices = AccountServices();
  int _page = 0;
  double bottomBarwidth = 42;
  double bottomBarBorderwidth = 5;

  List<Widget> pages = [
    HomeScreen(),
    AccountScreen(),
    CartScreen(),
  ];

  void updatePage(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              // Image.asset('images/appbaricon.png', width: mq.width*.15,height: mq.height*.15,),
              appbaricon,
              SizedBox(width: mq.width*.05,),
              user.type == 'plusmember' ? Text("${appName} PLUS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)):
              Text(appName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=> AboutUsScreen()));
          }, icon: Icon(Icons.info_outline)),
        ],
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
              icon: Container(
            width: bottomBarwidth,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(
                  color: _page == 0
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottomBarBorderwidth),
            ),),
                  child: Icon(
                    Icons.home
                  ),
          ),
          label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Container(
            width: bottomBarwidth,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(
                  color: _page == 1
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottomBarBorderwidth),
            )),
                child: Icon(
                  Icons.account_circle_outlined
                ),
          ),
          label: "Account",
          ),
          BottomNavigationBarItem(
              icon: Container(
            width: bottomBarwidth,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(
                  color: _page == 2
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottomBarBorderwidth),
            )),
                child: badges.Badge(
                   badgeContent: Text(userCartLen.toString(), style: TextStyle(color: Colors.white),),
                   badgeStyle: badges.BadgeStyle(
                   badgeColor: AppStyle.mainColor,
                   elevation: 0,),
                  child: Icon(
                    Icons.shopping_cart
                  ),
                ),
          ),
          label: "Cart",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        accountServices.changeUserType(context: context, type: 'user');
      }, label: Text("Be user")),
    );
  }
}
