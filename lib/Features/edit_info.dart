import 'package:bluemark/Features/Address/screens/address_editor.dart';
import 'package:bluemark/Styles/app_style.dart';
import 'package:bluemark/constants/utils.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Common/widgets/custom_button.dart';
import '../Pages/homescreen/Services/home_services.dart';

class EditUserInfo extends StatefulWidget {
  const EditUserInfo({super.key});

  @override
  State<EditUserInfo> createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  final _formkey = GlobalKey<FormState>();
  HomeServices homeServices = HomeServices();


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Edit ${user.name}'s Info", style: TextStyle(
            color: Colors.white
        ),),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  initialValue: user.name,
                  onSaved: (name) => user.name = name ?? '',
                  validator: (name) =>
                  name != null && name.isNotEmpty ? null : "Required Field",
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: "User Name",
                      label: Text("User Name")),
                ),
                SizedBox(height: 15,),
                CustomButton(text: 'Update', onTap: (){
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                  }
                  homeServices.UpdateUserInfo(context: context, name: user.name, user: user, onSuccess: (){
                    showSnackBar(context, "Info Updated Successfully");
                    Navigator.pop(context);
                  });}
                  ),
                SizedBox(height: 15,),
                user.type != 'seller' ? user.address.isNotEmpty ?
                Container(alignment: Alignment.bottomRight, child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> AddressEditorScreen()));
                }, child: Text("Edit Address", style: TextStyle(color: AppStyle.mainColor),),)):
                Container(alignment: Alignment.bottomRight, child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> AddressEditorScreen()));
                }, child: Text("Add Address", style: TextStyle(color: AppStyle.mainColor),),))
                    : SizedBox(),
                SizedBox(height: 20,),
                user.type != 'seller' ?
                Text("You can only change your name and address"):
                Text("You can only change your name"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
