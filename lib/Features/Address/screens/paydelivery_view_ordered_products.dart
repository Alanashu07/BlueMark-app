import 'package:bluemark/Features/Address/services/address_services.dart';
import 'package:bluemark/Features/order_details/screen/order_success.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Styles/app_style.dart';
import '../../../providers/user_provider.dart';
import '../../cart/widgets/cart_product.dart';

class PayDeliveryViewOrderedProducts extends StatefulWidget {
  final String address;
  const PayDeliveryViewOrderedProducts({super.key, required this.address});

  @override
  State<PayDeliveryViewOrderedProducts> createState() => _PayDeliveryViewOrderedProductsState();
}

class _PayDeliveryViewOrderedProductsState extends State<PayDeliveryViewOrderedProducts> {

  AddressServices addressServices = AddressServices();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    int sum = 0;
    user.type == 'user' ?
    user.cart.map((e) => sum+=e['quantity']*e['product']['retailprice'] as int).toList() :
    user.cart.map((e) => sum+=e['quantity']*e['product']['plusmemberprice'] as int).toList();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("View Order Details", style: TextStyle(color: Colors.white),),
      ),
      body: user.cart.length == 0 ? Padding(padding: EdgeInsets.all(16), child: Text("Please add some items in cart to order", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),):
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Confirm Your Order:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Divider(),
              SizedBox(height: 15,),
              ListView.builder(
                  itemCount: user.cart.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CartProduct(index: index);
                  }),
              SizedBox(height: 15,),
              Divider(),
              SizedBox(height: 15,),
              Text("Delivery Address:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
              SizedBox(height: 15,),
              Text(user.address, style: TextStyle(fontSize: 18),),
              SizedBox(height: 25,),
              Container(
                child: Text("Amount Payable: ₹ ${sum}", style: TextStyle(fontSize: 18),),
              ),
              SizedBox(height: 15,),
              Container(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppStyle.mainColor),
                  onPressed: (){
                    addressServices.placeOrder(context: context, address: widget.address, totalSum: sum.toDouble(), isPaid: false);
                  },
                  child: Text("Confirm Order", style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(height: 15,)
            ],
          ),
        ),
      ),
    );
  }
}
