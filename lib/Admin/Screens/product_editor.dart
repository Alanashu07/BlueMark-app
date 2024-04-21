import 'package:bluemark/Admin/Services/admin_services.dart';
import 'package:bluemark/Common/widgets/custom_button.dart';
import 'package:bluemark/Pages/homescreen/Services/home_services.dart';
import 'package:bluemark/constants/utils.dart';
import 'package:bluemark/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';

class ProductEditorScreen extends StatefulWidget {
  final Product product;
  const ProductEditorScreen({super.key, required this.product});

  @override
  State<ProductEditorScreen> createState() => _ProductEditorScreenState();
}

class _ProductEditorScreenState extends State<ProductEditorScreen> {
  final _formkey = GlobalKey<FormState>();
  AdminServices adminServices = AdminServices();
  HomeServices homeServices = HomeServices();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Edit Product ${widget.product.name}", style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.product.name,
                  onSaved: (name) => widget.product.name = name ?? '',
                  validator: (name) =>
                  name != null && name.isNotEmpty ? null : "Required Field",
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: "Product Name",
                      label: Text("Product Name")),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  initialValue: widget.product.description,
                  onSaved: (description) => widget.product.description = description ?? '',
                  validator: (description) =>
                  description != null && description.isNotEmpty ? null : "Required Field",
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: "Product Description",
                      label: Text("Product Description")),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  initialValue: widget.product.retailprice.toString(),
                  onSaved: (retailprice) => widget.product.retailprice = double.parse(retailprice ?? ''),
                  validator: (retailprice) =>
                  retailprice != null && retailprice.isNotEmpty ? null : "Required Field",
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: "Product Retail Price",
                      label: Text("Product Retail Price")),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  initialValue: widget.product.wholesaleprice.toString(),
                  onSaved: (wholesaleprice) => widget.product.wholesaleprice = double.parse(wholesaleprice ?? ''),
                  validator: (wholesaleprice) =>
                  wholesaleprice != null && wholesaleprice.isNotEmpty ? null : "Required Field",
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: "Product Wholesale Price",
                      label: Text("Product Wholesale Price")),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  initialValue: widget.product.plusmemberprice.toString(),
                  onSaved: (plusmemberprice) => widget.product.plusmemberprice = double.parse(plusmemberprice ?? ''),
                  validator: (plusmemberprice) =>
                  plusmemberprice != null && plusmemberprice.isNotEmpty ? null : "Required Field",
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: "Plus Member Price",
                      label: Text("Plus Member Price")),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  initialValue: widget.product.quantity.toString(),
                  onSaved: (quantity) => widget.product.quantity = double.parse(quantity ?? ''),
                  validator: (quantity) =>
                  quantity != null && quantity.isNotEmpty ? null : "Required Field",
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: "Product Quantity",
                      label: Text("Product Quantity")),
                ),
                SizedBox(height: 20,),
                // TextFormField(
                //   initialValue: widget.product.name,
                //   onSaved: (val) => widget.product.name = val ?? '',
                //   validator: (val) =>
                //   val != null && val.isNotEmpty ? null : "Required Field",
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(12)),
                //       hintText: "Product Name",
                //       label: Text("Product Name")),
                // ),
                // SizedBox(height: 20,),
                user.type == 'admin' ?
                CustomButton(text: 'Update', onTap: (){
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                  }
                  adminServices.updateProduct(context: context, product: widget.product, onSuccess: (){
                    showSnackBar(context, "Product Updated Successfully!");
                    Navigator.pop(context);
                    }, name: widget.product.name, description: widget.product.description, retailprice: widget.product.retailprice, wholesaleprice: widget.product.wholesaleprice, quantity: widget.product.quantity, plusmemberprice: widget.product.plusmemberprice);}):
                CustomButton(text: 'Update', onTap: (){
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                  }
                  homeServices.updateProduct(context: context, product: widget.product, onSuccess: (){
                    showSnackBar(context, "Product Updated Successfully!");
                    Navigator.pop(context);
                    }, name: widget.product.name, description: widget.product.description, retailprice: widget.product.retailprice, wholesaleprice: widget.product.wholesaleprice, quantity: widget.product.quantity, plusmemberprice: widget.product.plusmemberprice);})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
