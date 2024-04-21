import 'package:bluemark/Common/widgets/bottom_bar.dart';
import 'package:bluemark/Styles/app_style.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({super.key});

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {

  @override
  void initState() {
    super.initState();
   setState(() {

   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Order Placed Successfully!",
          style: TextStyle(color: Colors.white),
        ),
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
              Text("Your Order has been Placed Successfully!", style: TextStyle(color: AppStyle.accentColor, fontSize: 20, fontWeight: FontWeight.w500),),
              SizedBox(height: 15,),
              Text("Thank You for ordering on ${appName}", style: TextStyle(fontSize: 18),),
              SizedBox(height: 20,),
              Text("Keep shopping in ${appName} and enjoy exclusive offers!", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
              SizedBox(height: 30,),
              Expanded(
                child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text("Contact Us for more details and opinions", style: TextStyle(fontSize: 18),)),
              ),
              SizedBox(height: 35,),
              ElevatedButton(onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> BottomBar()), (route) => false);
              }, child: Text("Go Home")),
              SizedBox(height: 15,)
            ],
          ),
        ),
      ),
    );
  }
}
