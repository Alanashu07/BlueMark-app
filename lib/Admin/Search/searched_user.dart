import 'package:bluemark/Common/widgets/stars.dart';
import 'package:bluemark/Styles/app_style.dart';
import 'package:bluemark/models/user.dart';
import 'package:flutter/material.dart';
import '../../../models/product.dart';

class SearchedUser extends StatelessWidget {
  final User user;

  const SearchedUser({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                width: 235,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  user.name,
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  maxLines: 2,
                ),
              ),
              Container(
                width: 235,
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  user.type
                ),
              ),
              Container(
                width: 235,
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  user.type,
                  style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
              ),
              Container(
                width: 235,
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(user.id),
              ),
              Container(
                width: 235,
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(user.address, maxLines: 2, overflow: TextOverflow.ellipsis,),
              ),
            ],
          ),
        )
      ],
    );
  }
}
