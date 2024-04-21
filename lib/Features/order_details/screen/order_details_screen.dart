import 'package:bluemark/Admin/Search/admin_search_user.dart';
import 'package:bluemark/Admin/Services/admin_services.dart';
import 'package:bluemark/Common/widgets/custom_button.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Admin/Screens/admin_product_details_screen.dart';
import '../../../models/order.dart';
import '../../Product_Details/Screens/product_details_screen.dart';
import '../../Search/screens/search_screen.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order order;

  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  void navigateToSearchScreen(String query) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => SearchScreen(searchQuery: query)));
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  //!!! ONLY FOR ADMIN !!!
  void changeOrderStatus(int status){
    adminServices.changeOrderStatus(context: context, status: status+1, order: widget.order, onSuccess: (){
      setState(() {
        currentStep+=1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title:
        user.type == 'user' || user.type == 'plusmember' ?
        widget.order.products.length == 1 ?
            Text("Your Order of ${widget.order.products[0].name}", style: TextStyle(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,) :
            Text("Your Order of ${widget.order.products.length} products", style: TextStyle(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,):
            widget.order.products.length == 1 ?
            Text("Order details for ${widget.order.products[0].name}", style: TextStyle(color: Colors.white), maxLines: 1,overflow: TextOverflow.ellipsis,):
            Text("Order details for ${widget.order.products.length} products")
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "View Order Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    user.type == 'admin' ?
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> UserSearchScreen(searchQuery: widget.order.userId)));
                          },
                          child: Text("Ordered User ID: ${widget.order.userId}")) : SizedBox(),
                    Text(
                        "Order Date:         ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}"),
                    Text("Order ID:             ${widget.order.id}"),
                    Text("Order Price:        ₹${widget.order.totalPrice.toInt()} + Delivery Charge"),
                    widget.order.isPaid == true
                      ?Text("Payment Type:   Google Pay (Paid)")
                      :Text("Payment Type:   Cash On Delivery"),
                  ],
                ),
              ),
              Container(alignment: Alignment.center, child: Text("Delivery Charge will be received in time of Delivery")),
              SizedBox(
                height: 10,
              ),
              Text(
                "Purchase Details:",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              if(user.type == 'admin') {
                                Navigator.push(context, MaterialPageRoute(builder: (_)=> AdminProductDetailScreen(product: widget.order.products[i])));
                              }
                              else if(user.type == 'seller' && widget.order.products[i].sellerid == user.id) {
                                Navigator.push(context, MaterialPageRoute(builder: (_)=> AdminProductDetailScreen(product: widget.order.products[i])));
                              } else {
                                Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetailScreen(product: widget.order.products[i])));}
                            },
                            child: Image.network(
                              widget.order.products[i].images[0],
                              height: 120,
                              width: 120,
                            ),
                          ),
                          SizedBox(
                            width: 10
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetailScreen(product: widget.order.products[i],)));
                                           },
                                  child: Text(
                                    widget.order.products[i].name,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text('Qty: ${widget.order.quantity[i]}'),
                              ],
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Text("Track Order", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration:
                BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if(user.type == 'admin' && currentStep!= 3) {
                      return CustomButton(text: "Done", onTap: ()=> changeOrderStatus(details.currentStep));
                    }
                    return SizedBox();
                  },
                  steps: [
                    Step(title: Text("Pending"), content: Text("Your order is yet to be shipped"), isActive: currentStep > 0, state: currentStep > 0 ? StepState.complete : StepState.indexed),
                    Step(title: Text("Completed"), content: Text("Your order has been shipped"), isActive: currentStep > 1, state: currentStep > 1 ? StepState.complete : StepState.indexed),
                    Step(title: Text("Out for delivery"), content: Text("Your order will arrive today"), isActive: currentStep > 2, state: currentStep > 2 ? StepState.complete : StepState.indexed),
                    Step(title: Text("Delivered"), content: Text("Your order has completely delivered"), isActive: currentStep >= 3, state: currentStep >= 3 ? StepState.complete : StepState.indexed),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Text("Delivery Address", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delivery to:", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    Text(widget.order.address, style: TextStyle(fontSize: 15),)
                  ],
                ),
              ),
              Container(alignment: Alignment.center, child: Text("To Cancel order, Contact Blue Mark")),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}
