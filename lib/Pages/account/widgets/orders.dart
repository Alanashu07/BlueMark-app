import 'package:bluemark/Common/widgets/loader.dart';
import 'package:bluemark/Features/order_details/screen/order_details_screen.dart';
import 'package:bluemark/Pages/account/services/account_services.dart';
import 'package:bluemark/Pages/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

import '../../../models/order.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null ? Loader() : Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, top: 10, right: 15),
              child: Text(
                "Your Orders",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(left: 15, top: 15, right: 15),
            //   child: orders!.length == 0 ? SizedBox() : GestureDetector(
            //     onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=> AllOrdersScreen(order: orders![i],)));},
            //     child: Text(
            //       "See all",
            //       style: TextStyle(color: GlobalVariables.selectedNavBarColor),
            //     ),
            //   ),
            // ),
          ],
        ),
        //display orders
        Container(
          height: 170,
          padding: EdgeInsets.only(left: 10, top: 20, right: 0),
          child: orders!.length == 0 ? Text("No Orders yet!") : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: orders!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderDetailsScreen(order: orders![index])));},
                    child: SingleProduct(image: orders![index].products[0].images[0]));
              }),
        )
      ],
    );
  }
}
