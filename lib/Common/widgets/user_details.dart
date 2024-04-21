import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Container(width: double.infinity, child: Text("Your Details:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),textAlign: TextAlign.start,)),
            SizedBox(height: 15,),
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all()),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text("User ID: ${user.id}", style: TextStyle(fontSize: 16),),
                )),
            SizedBox(height: 15,),
            Container(
              width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all()),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text("Name: ${user.name}", style: TextStyle(fontSize: 16),),
                )),
            SizedBox(height: 15,),
            Container(
              width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all()),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text("E-Mail: ${user.email}", style: TextStyle(fontSize: 16),),
                )),
            SizedBox(height: 15,),
            if(user.address.isNotEmpty && user.type != 'seller')
            Container(
              width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all()),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text("Address: \n${user.address}", style: TextStyle(fontSize: 16),),
                )),
          ],
        ),
      ),
    );
  }
}
