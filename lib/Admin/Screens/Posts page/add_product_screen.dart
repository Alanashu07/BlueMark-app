import 'dart:io';
import 'package:bluemark/Admin/Services/admin_services.dart';
import 'package:bluemark/Common/widgets/custom_button.dart';
import 'package:bluemark/Common/widgets/custom_textfield.dart';
import 'package:bluemark/Pages/homescreen/Services/home_services.dart';
import 'package:bluemark/constants/utils.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Styles/app_style.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController ProductNameController = TextEditingController();
  final TextEditingController DescriptionController = TextEditingController();
  final TextEditingController RetailPriceController = TextEditingController();
  final TextEditingController WholesalePriceController = TextEditingController();
  final TextEditingController QuantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  final HomeServices homeServices = HomeServices();

  String category = 'Watches';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    ProductNameController.dispose();
    DescriptionController.dispose();
    RetailPriceController.dispose();
    WholesalePriceController.dispose();
    QuantityController.dispose();
  }

  List<String> productCategories = [
    'Watches',
    'Key Chain',
    'HeadPhones',
    'Speakers',
    'Electronics',
    'Cosmetics',
    'Appliances',
    'Shirts',
    'T-Shirts',
    'Gents Wear',
    'Ladies Wear',
    'Foot Wear',
    'Vegetables',
    'Fruits',
    'Bakery Items',
  ];

  // void sellerSellProduct() {
  //   if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
  //     homeServices.sellProduct(
  //         context: context,
  //         name: ProductNameController.text,
  //         description: DescriptionController.text,
  //         retailprice: double.parse(RetailPriceController.text),
  //         wholesaleprice: double.parse(WholesalePriceController.text),
  //         plusmemberprice: (double.parse(RetailPriceController.text) + double.parse(WholesalePriceController.text))/2,
  //         quantity: double.parse(QuantityController.text),
  //         category: category,
  //         images: images);
  //     setState(() {});
  //   }
  // }
  //
  // void sellProduct() {
  //   if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
  //     adminServices.sellProduct(
  //         context: context,
  //         name: ProductNameController.text,
  //         description: DescriptionController.text,
  //         retailprice: double.parse(RetailPriceController.text),
  //         wholesaleprice: double.parse(WholesalePriceController.text),
  //         plusmemberprice: (double.parse(RetailPriceController.text) + double.parse(WholesalePriceController.text))/2,
  //         quantity: double.parse(QuantityController.text),
  //         category: category,
  //         images: images);
  //     setState(() {});
  //   }
  // }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Add Product",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options:
                            CarouselOptions(viewportFraction: 1, height: 200))
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          dashPattern: [10, 4],
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 40,
                                  color: Colors.grey.shade400,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Select Product Images",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 30,
                ),
                CustomTextField(
                    controller: ProductNameController,
                    hintText: 'Product Name'),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: DescriptionController,
                    hintText: 'Description', MaxLines: 5),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: WholesalePriceController,
                    hintText: 'Wholesale Price'),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: RetailPriceController,
                    hintText: 'Retail Price'),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: QuantityController, hintText: 'Stock Quantity'),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                user.type == 'admin' ?
                CustomButton(text: 'Add Product', onTap: (){
                  if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
                    adminServices.sellProduct(
                        context: context,
                        name: ProductNameController.text,
                        description: DescriptionController.text,
                        sellername: user.name,
                        sellerid: user.id,
                        retailprice: double.parse(RetailPriceController.text),
                        wholesaleprice: double.parse(WholesalePriceController.text),
                        plusmemberprice: (double.parse(RetailPriceController.text) + double.parse(WholesalePriceController.text))/2,
                        quantity: double.parse(QuantityController.text),
                        category: category,
                        images: images);
                    setState(() {});
                  }
                }):
                CustomButton(text: 'Add Product', onTap: (){
                  if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
                    homeServices.sellProduct(
                        context: context,
                        name: ProductNameController.text,
                        description: DescriptionController.text,
                        sellername: user.name,
                        sellerid: user.id,
                        retailprice: double.parse(RetailPriceController.text),
                        wholesaleprice: double.parse(WholesalePriceController.text),
                        plusmemberprice: (double.parse(RetailPriceController.text) + double.parse(WholesalePriceController.text))/2,
                        quantity: double.parse(QuantityController.text),
                        category: category,
                        images: images);
                    setState(() {});
                  }
                }),
                SizedBox(height: 25,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
