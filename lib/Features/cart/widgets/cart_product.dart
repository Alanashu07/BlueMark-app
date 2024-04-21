import 'package:bluemark/Features/Product_Details/Screens/product_details_screen.dart';
import 'package:bluemark/Features/Product_Details/Services/product_details_services.dart';
import 'package:bluemark/Features/cart/services/cart_services.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Styles/app_style.dart';
import '../../../models/product.dart';

class CartProduct extends StatefulWidget {
  final int index;

  const CartProduct({Key? key, required this.index}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(Product product) {
    productDetailsServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetailScreen(product: product)));
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Image.network(
                  product.images[0],
                  fit: BoxFit.contain,
                  height: 135,
                  width: 135,
                ),
                SizedBox(width: 10,),
                Column(
                  children: [
                    Container(
                      width: 200,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.name,
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        maxLines: 2,
                      ),
                    ),
                    user.type == 'user' ?
                    Container(
                      width: 200,
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        '₹${product.retailprice.toInt()}',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ):
                    Container(
                      width: 200,
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        '₹${product.plusmemberprice.toInt()}',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 200,
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        'Delivery Charges Apply!',
                        maxLines: 2,
                      ),
                    ),
                    product.quantity == 0
                        ? Container(
                            width: 200,
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Out of Stock!',
                              style: TextStyle(color: Colors.red),
                              maxLines: 2,
                            ),
                          )
                        : product.quantity < 10
                            ? Container(
                                width: 200,
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Only ${product.quantity.toInt()} left!',
                                  style: TextStyle(color: Colors.red),
                                  maxLines: 2,
                                ),
                              )
                            : Container(
                                width: 200,
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'In Stock now',
                                  style: TextStyle(color: AppStyle.accentColor),
                                  maxLines: 2,
                                ),
                              ),
                  ],
                )
              ],
            ),
          ),
          product.quantity == 0 ? SizedBox() :
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1.5),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black12),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => decreaseQuantity(product),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.remove,
                            size: 18,
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: (BoxDecoration(
                            border: Border.all(color: Colors.black12, width: 1.5),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0))),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Text(
                            quantity.toString(),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => increaseQuantity(product),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
