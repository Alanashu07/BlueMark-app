import 'package:bluemark/Features/Search/screens/search_screen.dart';
import 'package:bluemark/Pages/homescreen/widgets/adress_box.dart';
import 'package:bluemark/Pages/homescreen/widgets/carousel_image.dart';
import 'package:bluemark/Pages/homescreen/widgets/deal_of_day.dart';
import 'package:bluemark/Pages/homescreen/widgets/top_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void navigateToSearchScreen(String query) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen(searchQuery: query)));
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
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
                      hintText: "Search for products",
                      helperStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      )
                    ),
                  ),
                )
              ),
            ),
            // Container(
            //   color: Colors.transparent,
            //   height: 42,
            //   margin: EdgeInsets.symmetric(horizontal: 10),
            //   child: Icon(Icons.mic, color: Colors.white,size: 25,),
            // )
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            if(user.type != 'seller')
            AddressBox(),
            SizedBox(height: 10,),
            TopCategories(),
            SizedBox(height: 10,),
            // CarouselImage(),
            DealOfDay(),
          ],
        ),
      )
    );
  }
}
