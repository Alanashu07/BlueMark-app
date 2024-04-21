import 'package:bluemark/Features/Address/screens/address_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=> AddressViewerScreen()));
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(color: Color.fromARGB(255, 33, 13, 150)),
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Icon(Icons.location_on_outlined),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "Delivery to ${user.name} - ${user.address}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 5, top: 2),
            child: Icon(Icons.arrow_right),),
          ],
        ),
      ),
    );
  }
}
