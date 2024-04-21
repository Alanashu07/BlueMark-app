import 'package:bluemark/Admin/Screens/Posts%20page/posts_screen.dart';
import 'package:bluemark/Admin/Screens/adminlogout.dart';
import 'package:bluemark/Admin/Screens/analytics_screen.dart';
import 'package:bluemark/Admin/Screens/orders_screen.dart';
import 'package:bluemark/Admin/Search/pre_search_user.dart';
import 'package:bluemark/Pages/account/services/account_services.dart';
import 'package:flutter/material.dart';
import '../../Features/Search/screens/search_screen.dart';
import '../../constants/global_variables.dart';
import '../../main.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AccountServices accountServices = AccountServices();

  int _page = 0;
  double bottomBarwidth = 42;
  double bottomBarBorderwidth = 5;

  List<Widget> pages = [
    PostsScreen(),
    AnalyticsScreen(),
    OrdersScreen(),
  ];

  void updatePage(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              appbaricon,
              // Image.asset('images/appbaricon.png', width: mq.width*.15,height: mq.height*.15,),
              SizedBox(width: mq.width*.05,),
              Text("BLUE MARK", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        actionsIconTheme: IconThemeData(
            color: Colors.white
        ),
        actions: [
          // IconButton(onPressed: (){
          //   Navigator.push(context, MaterialPageRoute(builder: (_)=>PreSearchScreen()));
          // }, icon: Icon(Icons.search)),
          // SizedBox(width: 5,),
          GestureDetector(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=> AdminLogOut()));},
            child: Text('Admin   ', style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),),
          )
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
            label: "Posts",
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
                  Icons.currency_rupee_sharp, size: 25,
              ),
            ),
            label: "Earnings",
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
              child: Icon(
                  Icons.all_inbox_rounded
              ),
            ),
            label: "Orders",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        accountServices.changeUserType(context: context, type: 'user');
      }, label: Text("Be user")),
    );
  }
}
