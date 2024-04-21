import 'dart:convert';
import 'package:bluemark/Common/widgets/bottom_bar.dart';
import 'package:bluemark/constants/error_handling.dart';
import 'package:bluemark/constants/utils.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/global_variables.dart';
import '../models/login_response_model.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  //sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          referral: 0.toString(),
          token: '',
          cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Account has been created, Login with the same Credentials!");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {

      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> BottomBar()), (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get user data

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      
      if(token == null){
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!
      }
      );

      var response = jsonDecode(tokenRes.body);

      if(response == true){
        //get user data
       http.Response userRes =  await http.get(Uri.parse('$uri/'),
           headers: <String, String>{
             'Content-Type': 'application/json; charset=UTF-8',
             'x-auth-token': token
           }
       );
       
       var userProvider = Provider.of<UserProvider>(context, listen: false);
       userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static var client = http.Client();

  Future<LoginResponseModel> otpLogin(String email) async {
    // var url = Uri.http('$uri', '/api/otp-login');

    var url = Uri.parse('$uri/api/otp-login');
      var response = await client.post(url, headers: {'Content-type': "application/json"},
      body: jsonEncode({
        "email": email
      })
      );
      return loginResponseModel(response.body);
  }
  Future<LoginResponseModel> verifyOTP(String email, String otpHash, String otpCode) async {
    var url = Uri.http('$uri', '/api/otp-verify');

      var response = await client.post(url, headers: {'Content-type': "application/json"},
      body: jsonEncode({
        "email": email,
        "otp": otpCode,
        "hash": otpHash
      })
      );
      return loginResponseModel(response.body);
  }
}
