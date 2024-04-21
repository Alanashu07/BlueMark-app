import 'package:bluemark/Styles/app_style.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SellerSuccessScreen extends StatefulWidget {
  const SellerSuccessScreen({super.key});

  @override
  State<SellerSuccessScreen> createState() => _SellerSuccessScreenState();
}

class _SellerSuccessScreenState extends State<SellerSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Welcome As Seller", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(height: 25,),
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
                      )),
                ),
              ),
              SizedBox(height: 25,),
              Text("Congratulations! You successfully became ${appName} Seller", textAlign: TextAlign.center, style: TextStyle(color: AppStyle.accentColor, fontSize: 22, fontWeight: FontWeight.bold),),
              SizedBox(height: 45,),
              Text("You can now sell on Blue Mark and receive income"),
              SizedBox(height: 10,),
              Text("Please Restart the app to fully apply changes"),
              SizedBox(height: 40,),
              Container(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppStyle.mainColor),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Close App", style: TextStyle(color: Colors.white, fontSize: 18),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
