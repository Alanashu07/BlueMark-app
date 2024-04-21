import 'package:bluemark/Common/widgets/custom_button.dart';
import 'package:bluemark/Features/cart/widgets/cart_product.dart';
import 'package:bluemark/Features/cart/widgets/cart_subtotal.dart';
import 'package:bluemark/Pages/homescreen/widgets/adress_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../Address/screens/adress_screen.dart';
import '../../Search/screens/search_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => SearchScreen(searchQuery: query)));
  }
  void navigateToAddressScreen (int sum) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => AddressScreen(totalAmount: sum.toString())));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.type == 'user' ?
    user.cart.map((e) => sum+=e['quantity']*e['product']['retailprice'] as int).toList() :
    user.cart.map((e) => sum+=e['quantity']*e['product']['plusmemberprice'] as int).toList();
    return Scaffold(
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
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 1),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            AddressBox(),
            user.cart.isEmpty ? Text("No Items Here!") :
            CartSubtotal(),
            user.cart.isEmpty ? SizedBox() :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CustomButton(
                  text: "Proceed to Buy ${user.cart.length} items",
                  onTap: () =>navigateToAddressScreen(sum),
            ),
            ),
            SizedBox(
              height: 5,
            ),
            user.cart.isEmpty ? SizedBox() :
            Divider(),
            SizedBox(
              height: 5,
            ),
            ListView.builder(
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CartProduct(index: index);
                }),
          ],
        ),
      ),
    );
  }
}
