import 'package:bluemark/Admin/Screens/admin_product_details_screen.dart';
import 'package:bluemark/Common/widgets/loader.dart';
import 'package:bluemark/Features/Product_Details/Screens/product_details_screen.dart';
import 'package:bluemark/Features/Search/Services/search_services.dart';
import 'package:bluemark/Features/Search/widgets/searched_product.dart';
import 'package:bluemark/Pages/homescreen/widgets/adress_box.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;

  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  fetchSearchedProduct() async {
    products = await searchServices.fetchSearchedProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => SearchScreen(searchQuery: query)));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return products == null
        ? Loader()
        : Scaffold(
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
                                hintText: "Search for products",
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
                if (user.type != 'admin' && user.type != 'seller') AddressBox(),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            user.type == 'user' || user.type == 'plusmember'
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ProductDetailScreen(
                                            product: products![index])))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            AdminProductDetailScreen(
                                                product: products![index])));
                          },
                          child: SearchedProduct(product: products![index]));
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
