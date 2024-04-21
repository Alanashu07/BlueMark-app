import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Admin/Screens/admin_product_details_screen.dart';
import '../Common/widgets/loader.dart';
import '../Features/Product_Details/Screens/product_details_screen.dart';
import '../Features/Search/screens/search_screen.dart';
import '../Styles/app_style.dart';
import '../constants/global_variables.dart';
import '../models/product.dart';
import '../providers/user_provider.dart';
import 'account/widgets/single_product.dart';
import 'homescreen/Services/home_services.dart';
import 'homescreen/category_deals_screen.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  List<Product>? products;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await homeServices.fetchProductsUser(context);
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
        ? Scaffold(
      body: Center(
        child: Loader(),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
    )
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
            itemCount: products!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 25),
            itemBuilder: (context, index) {
              final productData = products![index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      if(user.type == 'seller' && productData.sellerid == user.id) {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> AdminProductDetailScreen(product: productData)));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetailScreen(product: productData)));}
                    },
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: SingleProduct(
                        image: productData.images[0],
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          productData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )),
                  ),
                  SizedBox(height: 50,)
                ],
              );
            }),
      ),
    );
  }
}
