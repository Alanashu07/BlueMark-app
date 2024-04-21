import 'dart:convert';
import 'package:bluemark/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Features/auth/screens/customer_auth.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/api/orders/me'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });

      httpErrorHandle(response: res, context: context, onSuccess: () {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          orderList.add(
              Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void changeUserType({
    required BuildContext context,
    required String type,}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {


      http.Response res = await http.post(Uri.parse('$uri/api/change-user-type'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      },
        body: jsonEncode({'type': type}),
      );

      httpErrorHandle(response: res, context: context, onSuccess: (){
        User user = userProvider.user.copyWith(address: jsonDecode(res.body)['type']);
        userProvider.setUserFromModel(user);
        showSnackBar(context, "User Type Changed Successfully");
        // Navigator.pop(context);
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void logOut(BuildContext context) async{
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> CustomerAuthScreen()), (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}