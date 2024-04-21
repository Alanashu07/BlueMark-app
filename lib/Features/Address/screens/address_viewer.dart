import 'package:bluemark/Common/widgets/custom_button.dart';
import 'package:bluemark/Features/Address/screens/address_editor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class AddressViewerScreen extends StatelessWidget {
  const AddressViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Your Address", style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 35,),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.all(16),
              child: Text(user.address, style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20
              ),
              ),
            ),
            SizedBox(height: 20,),
            CustomButton(text: 'Update Address', onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>AddressEditorScreen()));
            })
          ],
        ),
      ),
    );
  }
}
