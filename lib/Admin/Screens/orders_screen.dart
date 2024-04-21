import 'package:bluemark/Admin/Services/admin_services.dart';
import 'package:bluemark/Common/widgets/loader.dart';
import 'package:bluemark/Features/order_details/screen/order_details_screen.dart';
import 'package:bluemark/Pages/account/widgets/single_product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? Loader()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 5),
              itemCount: orders!.length,
              itemBuilder: (context, index) {
                final orderData = orders![index];
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  OrderDetailsScreen(order: orderData)));
                    },
                    child: SizedBox(
                      height: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleProduct(
                            image: orderData.products[0].images[0],
                          ),
                          SizedBox(height: 5,),
                          Padding(padding: EdgeInsets.only(left: 8.0), child: Expanded(child: Text('${orderData.products[0].name}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.left,overflow: TextOverflow.ellipsis, maxLines: 1,)),),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Expanded(child: Text("${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(orderData.orderedAt))}", maxLines: 2, overflow: TextOverflow.ellipsis,)),
                          ),
                          orderData.status == 3 ?
                          Padding(padding: EdgeInsets.only(left: 8.0), child: Expanded(child: Text('Delivered Successfully!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.green), textAlign: TextAlign.left,overflow: TextOverflow.ellipsis, maxLines: 1,)),):
                          Padding(padding: EdgeInsets.only(left: 8.0), child: Expanded(child: Text('Not Delivered yet!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red), textAlign: TextAlign.left,overflow: TextOverflow.ellipsis, maxLines: 1,)),),
                        ],
                      ),
                    ));
              },
            ),
          );
  }
}
