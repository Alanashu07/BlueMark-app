import 'package:bluemark/Common/widgets/user_details.dart';
import 'package:bluemark/Features/edit_info.dart';
import 'package:bluemark/Pages/account/widgets/orders.dart';
import 'package:bluemark/Pages/account/widgets/top_buttons.dart';
import 'package:bluemark/Styles/app_style.dart';
import 'package:bluemark/constants/global_variables.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyle.mainColor,
        title: Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: RichText(
            text: TextSpan(
              text: "Hello,  ",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white
              ),
              children: [
                TextSpan(
                text: user.name,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
                )
              ]
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopButtons(),
            if(user.type != 'seller')
            Orders(),
            UserDetails(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.bottomRight,
              width: double.infinity,
              child: Container(
                width: 137,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> EditUserInfo()));
                }, child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 10,),
                  Text("Edit Info")
                ],
                ),
                ),
              ),
            ),
            SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }
}
