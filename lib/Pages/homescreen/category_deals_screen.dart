import 'package:bluemark/Features/Product_Details/Screens/product_details_screen.dart';
import 'package:bluemark/Pages/homescreen/Services/home_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Admin/Screens/admin_product_details_screen.dart';
import '../../Common/widgets/loader.dart';
import '../../main.dart';
import '../../models/product.dart';
import '../../providers/user_provider.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String category;

  const CategoryDealsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            widget.category,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      body: productList == null
          ? Loader()
          : productList!.length == 0
          ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset('images/smiling.png', scale: 5,),
                SizedBox(height: 20,),
                Container(width: double.infinity, child: Text("This Category will be available soon!", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),)),
              ],
            ),
          )
          :Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for ${widget.category}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(left: 15),
                      itemCount: productList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                          mainAxisSpacing: 35),
                      itemBuilder: (context, index) {
                        final product = productList![index];
                        return GestureDetector(
                          onTap: (){if(user.type == 'seller' && product.sellerid == user.id) {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> AdminProductDetailScreen(product: product)));
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetailScreen(product: product)));}},
                          child: Column(
                            children: [
                              SizedBox(
                                height: 160,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black12, width: 0.5)),
                                  child: Container(height: 150, width: 150, padding: EdgeInsets.all(10),child: Image.network(product.images[0], fit: BoxFit.contain,),),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 25, top: 5),
                                child: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,),
                              ),
                              SizedBox(height: 35,)
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
    );
  }
}
