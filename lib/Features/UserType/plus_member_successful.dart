import 'package:bluemark/Styles/app_style.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class PlusMemberSuccessful extends StatefulWidget {
  const PlusMemberSuccessful({super.key});

  @override
  State<PlusMemberSuccessful> createState() => _PlusMemberSuccessfulState();
}

class _PlusMemberSuccessfulState extends State<PlusMemberSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Welcome As Plus Member",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Positioned(
                  top: mq.height * .15,
                  right: mq.width * .25,
                  width: mq.width * .5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      color: Colors.blue,
                      child: Icon(
                        Icons.done,
                        size: mq.height * .1,
                      ),
                    ),
                  )),
              SizedBox(
                height: 25,
              ),
              Text(
                "Congratulations! You have Successfully registered as ${appName} Plus Member",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppStyle.accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(height: 45,),
              Text("You can now buy products from ${appName} for an additional discount", textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              Text("Please Restart the App for applying changes completely")
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Navigator.pop(context);
      }, label: Row(children: [
        Icon(Icons.exit_to_app, color: Colors.white,),
        SizedBox(width: 10,),
        Text("Exit App", style: TextStyle(color: Colors.white),)
      ],), backgroundColor: AppStyle.mainColor),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
