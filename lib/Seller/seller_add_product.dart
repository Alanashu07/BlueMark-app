import 'package:bluemark/Admin/Screens/Posts%20page/add_product_screen.dart';
import 'package:bluemark/Admin/Services/admin_services.dart';
import 'package:bluemark/Common/widgets/loader.dart';
import 'package:bluemark/Pages/account/widgets/single_product.dart';
import 'package:bluemark/Pages/homescreen/Services/home_services.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Features/Search/screens/search_screen.dart';
import '../../../models/product.dart';
import '../Admin/Screens/admin_product_details_screen.dart';
import '../Features/Product_Details/Screens/product_details_screen.dart';

class SellerPostsScreen extends StatefulWidget {
  const SellerPostsScreen({Key? key}) : super(key: key);

  @override
  State<SellerPostsScreen> createState() => _SellerPostsScreenState();
}

class _SellerPostsScreenState extends State<SellerPostsScreen> {
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

  void navigateToAddProduct() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => AddProductScreen()));
  }

  void deleteProduct(Product product, int index) {
    homeServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
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
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AddProductScreen()));
              },
              tooltip: "Add Product",
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          )
        : Scaffold(
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
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                  itemCount: products!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      mainAxisSpacing: 25),
                  itemBuilder: (context, index) {
                    final productData = products![index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if(user.type == 'seller' && products![index].sellerid == user.id) {
                              Navigator.push(context, MaterialPageRoute(builder: (_)=> AdminProductDetailScreen(product: products![index])));
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetailScreen(product: products![index])));}
                          },
                          child: SizedBox(
                            height: 140,
                            child: SingleProduct(
                              image: productData.images[0],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    productData.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  )),
                            ), productData.sellerid != user.id ? SizedBox() :
                            IconButton(
                                color: Colors.black54,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Delete Product ${productData.name}?",
                                          ),
                                          content: Text(
                                              "Your Product ${productData.name} will be deleted!"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                deleteProduct(
                                                    productData, index);
                                              },
                                              child: Text("Delete"),
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
                                },
                                icon: Icon(Icons.delete))
                          ],
                        )
                      ],
                    );
                  }),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: navigateToAddProduct,
              tooltip: "Add Product",
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
