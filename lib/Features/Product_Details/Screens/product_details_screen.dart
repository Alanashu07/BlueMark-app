import 'package:bluemark/Common/widgets/stars.dart';
import 'package:bluemark/Features/Product_Details/Services/product_details_services.dart';
import 'package:bluemark/Pages/image_viewer_screen.dart';
import 'package:bluemark/Styles/app_style.dart';
import 'package:bluemark/constants/utils.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../../models/product.dart';
import '../../Search/screens/search_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void addToCart() {
    productDetailsServices.addToCart(context: context, product: widget.product);
    showSnackBar(context, "Product Successfully added to cart");
  }

  void navigateToSearchScreen(String query) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => SearchScreen(searchQuery: query)));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['retailprice'] as int)
        .toList();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(widget.product.id!), Stars(rating: avgRating)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                widget.product.name,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
            GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=> ImageViewerScreen(product: widget.product)));},
              child: CarouselSlider(
                  items: widget.product.images.map(
                    (i) {
                      return Builder(
                        builder: (BuildContext context) => Image.network(
                          i,
                          fit: BoxFit.contain,
                          height: 200,
                        ),
                      );
                    },
                  ).toList(),
                  options: CarouselOptions(viewportFraction: 1, height: 300)),
            ),
            Divider(
              height: 5,
              thickness: 2.5,
            ),
            Padding(padding: EdgeInsets.all(8), child: Text("Description: ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),),
            Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15), child: Text(widget.product.description),),
            Padding(
              padding: EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: "Retail Price: ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: "₹${widget.product.retailprice.toInt()}",
                          style: TextStyle(
                              fontSize: 22,
                              color: AppStyle.accentColor,
                              fontWeight: FontWeight.w500)),
                    ]),
              ),
            ),
            user.type == 'plusmember' ?
            Padding(
              padding: EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: "Plus Member Price: ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: "₹${widget.product.plusmemberprice.toInt()}",
                          style: TextStyle(
                              fontSize: 22,
                              color: AppStyle.accentColor,
                              fontWeight: FontWeight.w500)),
                    ]),
              ),
            ) :
            Padding(
              padding: EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: "Be a Plus member and get this for:  ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: "₹${widget.product.plusmemberprice.toInt()}",
                          style: TextStyle(
                              fontSize: 22,
                              color: AppStyle.accentColor,
                              fontWeight: FontWeight.w500)),
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Delivery charges Apply!"),
            ),
            if (widget.product.quantity < 10 && widget.product.quantity != 0)
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Only ${widget.product.quantity.toInt()} left!",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
            if (widget.product.quantity == 0)
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Out of Stock!",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            Divider(
              height: 5,
              thickness: 2.5,
            ),
            // widget.product.quantity == 0
            //     ? SizedBox(
            //         height: 0,
            //       )
            //     : Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: ElevatedButton(
            //             onPressed: (){
            //               Navigator.push(context, MaterialPageRoute(builder: (_)=> BuyNowAddressScreen(totalAmount: widget.product.retailprice.toString())));
            //             },
            //             child: Text(
            //               "Buy Now",
            //               style: TextStyle(color: Colors.white),
            //             ),
            //             style: ElevatedButton.styleFrom(
            //                 minimumSize: Size(double.infinity, 50),
            //                 backgroundColor: AppStyle.mainColor)),
            //       ),
                widget.product.quantity == 0
                ? SizedBox()
                : user.type != 'seller' ?
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: addToCart,
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            backgroundColor: AppStyle.mainColor)),
                  ): SizedBox(),
            widget.product.quantity == 0
                ? SizedBox(
                    height: 0,
                  )
                : user.type != 'seller' ?
            Divider(
                    height: 5,
                    thickness: 2.5,
                  ): SizedBox(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Rate the Product",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            RatingBar.builder(
                initialRating: myRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: AppStyle.accentColor,
                    ),
                onRatingUpdate: (rating) {
                  productDetailsServices.rateProduct(
                      context: context,
                      product: widget.product,
                      rating: rating);
                  setState(() {});
                }),
            Divider(),
            SizedBox(height: 15,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("Seller: ${widget.product.sellername}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
            ),
            SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }
}
