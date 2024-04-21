import 'package:bluemark/Admin/Search/searched_user.dart';
import 'package:bluemark/Admin/Search/user_details.dart';
import 'package:bluemark/Common/widgets/loader.dart';
import 'package:bluemark/Features/Search/Services/search_services.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';

class UserSearchScreen extends StatefulWidget {
  final String searchQuery;

  const UserSearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  List<User>? users;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    findUser();
  }

  findUser() async {
    users = await searchServices.findUser(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => UserSearchScreen(searchQuery: query)));
  }

  @override
  Widget build(BuildContext context) {
    return users == null
        ? Loader()
        : users!.length == 0 ? SizedBox() : Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Expanded(
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
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(Icons.search),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.only(top: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide(
                                color: Colors.black38, width: 1),
                          ),
                          hintText: "Search for users by Id",
                          helperStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          )),
                    ),
                  )),
            ),
            // Container(
            //   color: Colors.transparent,
            //   height: 42,
            //   margin: EdgeInsets.symmetric(horizontal: 10),
            //   child: Icon(
            //     Icons.mic,
            //     color: Colors.white,
            //     size: 25,
            //   ),
            // )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  UserSearched(
                                      user: users![index])));
                    },
                    child: SearchedUser(user: users![index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
