import 'package:bluemark/Features/UserType/be_plus_member.dart';
import 'package:bluemark/Features/UserType/become_seller.dart';
import 'package:bluemark/Features/cart/screens/cart_screen.dart';
import 'package:bluemark/Pages/account/services/account_services.dart';
import 'package:bluemark/Pages/account/widgets/account_button.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final AccountServices accountServices = AccountServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Column(
      children: [
        user.type == 'user'
            ? Row(
                children: [
                  AccountButton(
                      text: 'Be Plus Member',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => BePlusMember()));
                      }),
                  AccountButton(
                      text: 'Become Seller',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => BecomeSeller()));
                      }),
                ],
              )
            : SizedBox(),
        Row(
          children: [
            user.type != 'seller' ?
            AccountButton(
                text: 'Go to Cart',
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => CartScreen()));
                }
                ): SizedBox(),
            AccountButton(
                text: 'Log Out',
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Sure to Log Out?",
                          ),
                          content: Text(
                              "You cannot explore the app until you login again!"),
                          actions: [
                            TextButton(
                              onPressed: () => accountServices.logOut(context),
                              child: Text("Log Out"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel"),
                            ),
                          ],
                        );
                      });
                }),
          ],
        ),
      ],
    );
  }
}
