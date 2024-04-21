import 'package:bluemark/Admin/Services/admin_services.dart';
import 'package:bluemark/Pages/account/services/account_services.dart';
import 'package:flutter/material.dart';

class AdminLogOut extends StatefulWidget {
  const AdminLogOut({Key? key}) : super(key: key);

  @override
  State<AdminLogOut> createState() => _AdminLogOutState();
}

class _AdminLogOutState extends State<AdminLogOut> {
  final AccountServices accountServices = AccountServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Log Out", style: TextStyle(color: Colors.white),),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){accountServices.logOut(context);}, label: Row(
        children: [
          Icon(Icons.logout),
          Text("Log Out")
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
