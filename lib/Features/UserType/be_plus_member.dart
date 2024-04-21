import 'package:bluemark/Features/UserType/plus_member_success.dart';
import 'package:bluemark/Features/UserType/plus_member_successful.dart';
import 'package:bluemark/Pages/account/services/account_services.dart';
import 'package:bluemark/main.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Styles/app_style.dart';

class BePlusMember extends StatefulWidget {
  const BePlusMember({super.key});

  @override
  State<BePlusMember> createState() => _BePlusMemberState();
}

class _BePlusMemberState extends State<BePlusMember> {

  AccountServices accountServices = AccountServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Become Plus Member", style: TextStyle(color: Colors.white),),
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
            Text("Being plus Member can give an additional discounts on products"),
            SizedBox(height: 15,),
            Text("This can give you faster delivery and much priorities"),
            SizedBox(height: 15,),
            Text("You have to share this app to a minimum of 20 people in order to be a ${appName} Plus Member"),
            SizedBox(height: 15,),
            Text("Plus Member is time limited make sure to do it quick!"),
            SizedBox(height: 15,),
            Text("Referral ID:", style: TextStyle(color: AppStyle.mainColor, fontSize: 18, fontWeight: FontWeight.w500),),
            Text(user.id, style: TextStyle(fontSize: 16),),
            SizedBox(height: 15,),
            Text("Total Referrals: ${user.referral}", style: TextStyle(color: AppStyle.accentColor, fontSize: 20, fontWeight: FontWeight.bold),),
            double.parse(user.referral) <= 20 ?
            SizedBox(height: 15,): SizedBox(),
            double.parse(user.referral) <= 20 ?
            Text("Remaining Referrals: ${20 - double.parse(user.referral).toInt()}", style: TextStyle(fontSize: 17),): SizedBox(),
            SizedBox(height: 35,),
            double.parse(user.referral) <= 20 ?
            Text("PLEASE SHARE THIS APP TO 20 PEOPLE. COME BACK OFTEN TO CHECK", textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppStyle.mainColor),):
            Text("Congratulations! You are now eligible to be a Plus Member, Now You can get Products for an additional discount, Click on confirm to be a plus member", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
            SizedBox(height: 25,),
            double.parse(user.referral) >= 20 ?
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(onPressed: (){
                  accountServices.changeUserType(context: context, type: 'plusmember');
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>PlusMemberSuccessful()), (route) => false);
                }, child: Text("Confirm", style: TextStyle(color: AppStyle.accentColor),),),
                MaterialButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel", style: TextStyle(color: AppStyle.accentColor)),),
              ],
            ) : MaterialButton(onPressed: (){
              Navigator.pop(context);
            }, child: Container(width: double.infinity, child: Text("Go Back", style: TextStyle(color: AppStyle.mainColor), textAlign: TextAlign.right,)),),
          ],
        ),),
      ),
    );
  }
}
