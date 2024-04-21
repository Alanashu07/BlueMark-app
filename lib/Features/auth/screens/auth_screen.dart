import 'package:bluemark/Features/auth/screens/admin_auth.dart';
import 'package:bluemark/Features/auth/screens/customer_auth.dart';
import 'package:bluemark/Styles/app_style.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Welcome to BLUE MARK",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: mq.width * .45,
                  height: mq.height * .25,
                  color: AppStyle.mainColor,
                  child: Container(
                    child: MaterialButton(
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_)=>AdminAuthScreen()));},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                              child: Text(
                            "Sign in as Blue Mark Staff",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: mq.width * .025,
                ),
                Container(
                  width: mq.width * .45,
                  height: mq.height * .25,
                  color: AppStyle.mainColor,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> CustomerAuthScreen()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign in as Customer",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
