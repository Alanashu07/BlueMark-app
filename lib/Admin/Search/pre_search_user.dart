import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import 'admin_search_user.dart';

class PreSearchScreen extends StatefulWidget {
  const PreSearchScreen({super.key});

  @override
  State<PreSearchScreen> createState() => _PreSearchScreenState();
}

class _PreSearchScreenState extends State<PreSearchScreen> {

  void navigateToSearchScreen(String query) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => UserSearchScreen(searchQuery: query)));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Expanded(
          child: Container(
              height: 42,
              margin: EdgeInsets.only(left: 15),
              child: Material(
                borderRadius: BorderRadius.circular(7),
                elevation: 1,
                child: TextFormField(
                  onFieldSubmitted: navigateToSearchScreen,
                  decoration: InputDecoration(
                      prefixIcon: InkWell(
                        onTap: (){},
                        child: Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Icon(Icons.search),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(top: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        borderSide: BorderSide(color: Colors.black38, width: 1),
                      ),
                      hintText: "Search for users by Id",
                      helperStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      )
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}
