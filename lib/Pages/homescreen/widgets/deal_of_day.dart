import 'package:bluemark/Admin/Screens/admin_product_details_screen.dart';
import 'package:bluemark/Common/widgets/loader.dart';
import 'package:bluemark/Features/Product_Details/Screens/product_details_screen.dart';
import 'package:bluemark/Pages/Categories.dart';
import 'package:bluemark/Pages/homescreen/Services/home_services.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return product == null
        ? Loader()
        : product!.name.isEmpty
            ? Text("No items yet!")
            : GestureDetector(
              onTap: (){if(user.type == 'seller' && product!.sellerid == user.id) {
                Navigator.push(context, MaterialPageRoute(builder: (_)=> AdminProductDetailScreen(product: product!)));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetailScreen(product: product!)));}
                },
              child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 10, top: 15),
                      child: Text(
                        "Deal of the day",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                     product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text(
                        "₹${product!.retailprice.toInt()}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: Text(
                        product!.category,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images.map((e)=> Image.network(
                          e,
                          height: 235,
                          fit: BoxFit.fitHeight,
                        ),).toList()
                      ),
                    ),
                    GestureDetector(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=> AllCategories()));},
                      child: Container(
                        padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Explore all Products",
                          style: TextStyle(color: Colors.cyan[800]),
                        ),
                      ),
                    ),
                  ],
                ),
            );
  }
}
