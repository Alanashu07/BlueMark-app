import 'package:bluemark/Pages/account/services/account_services.dart';
import 'package:bluemark/Seller/seller_success.dart';
import 'package:bluemark/Styles/app_style.dart';
import 'package:bluemark/main.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BecomeSeller extends StatefulWidget {
  const BecomeSeller({super.key});

  @override
  State<BecomeSeller> createState() => _BecomeSellerState();
}

class _BecomeSellerState extends State<BecomeSeller> {

  AccountServices accountServices = AccountServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Become Seller", style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(10), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Read this carefully:", style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20
            ),
            ),
            SizedBox(height: 15,),
            Text("This will make you able to sell products on ${appName}."),
            SizedBox(height: 15,),
            Text("This process is final and cannot be reverted back to Buyer!"),
            SizedBox(height: 15,),
            Text("Make sure you logged in with your business account"),
            SizedBox(height: 15,),
            Text("If Not, Log out and log in again with your business account"),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(onPressed: (){
                  accountServices.changeUserType(context: context, type: 'seller');
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> SellerSuccessScreen()), (route) => false);
                }, child: Text("Confirm", style: TextStyle(color: AppStyle.accentColor),),),
                MaterialButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel", style: TextStyle(color: AppStyle.accentColor)),),
              ],
            )
          ],
        ),),
      ),
    );
  }
}
