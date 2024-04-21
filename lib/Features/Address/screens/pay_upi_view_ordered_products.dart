import 'package:bluemark/Features/payment/payment_screen.dart';
import 'package:bluemark/Styles/app_style.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../cart/widgets/cart_product.dart';
import '../services/address_services.dart';

class PayUPIViewOrderedProducts extends StatefulWidget {
  final String address;
  const PayUPIViewOrderedProducts({super.key, required this.address});

  @override
  State<PayUPIViewOrderedProducts> createState() => _PayUPIViewOrderedProductsState();
}

class _PayUPIViewOrderedProductsState extends State<PayUPIViewOrderedProducts> {
  Map<String, dynamic>? paymentIntent;

  final AddressServices addressServices = AddressServices();
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
              Container(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppStyle.mainColor),
                  onPressed: (){
                    // payment();
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>UPIPaymentScreen(totalAmount: sum.toString())));
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

  // Future<void> payment () async {
  //   try {
  //     Map<String, dynamic> body = {
  //       'amount': sum * 100,
  //       'currency': "INR",
  //     };
  //
  //     var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //       headers: {
  //         'Authorization': 'Bearer sk_test_51NcuCISJ9wXxWoxeAaZhxjZ4ynlBFDowVUd5A2o8U8pRVmCQaG1Njy0zFPFzIH0S6IgELJK3zaeboGcCAWo9fDPa0085cu8P5v',
  //         'Content-type': 'application/x-www-form-urlencoded'
  //       },
  //     );
  //     paymentIntent = json.decode(response.body);
  //
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  //   var gpay = PaymentSheetGooglePay(merchantCountryCode: "IN", currencyCode: "INR");
  //
  //   await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
  //     paymentIntentClientSecret: paymentIntent!['client_secret'],
  //     style: ThemeMode.system,
  //     merchantDisplayName: 'Blue Mark',
  //     googlePay: gpay,
  //   )).then((value) => {});
  //
  //   try {
  //     await Stripe.instance.presentPaymentSheet().then((value) => {
  //       addressServices.placeOrder(context: context, address: Provider.of<UserProvider>(context).user.address, totalSum: double.parse(sum.toString()), isPaid: true)
  //     });
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }

}