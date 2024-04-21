import 'package:bluemark/Features/Address/screens/pay_upi_view_ordered_products.dart';
import 'package:bluemark/Features/Address/screens/paydelivery_view_ordered_products.dart';
import 'package:bluemark/Features/Address/services/address_services.dart';
import 'package:bluemark/Styles/app_style.dart';
import 'package:bluemark/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import '../../../Common/widgets/custom_textfield.dart';
import '../../../providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  final String totalAmount;

  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController housenoController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController landMarkController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = '';
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    housenoController.dispose();
    areaController.dispose();
    cityController.dispose();
    landMarkController.dispose();
    pinCodeController.dispose();
    phoneController.dispose();
  }

  void onGooglePayResult(res) {
    if(Provider.of<UserProvider> (context, listen: false).user.address.isEmpty) {
      addressServices.saveUserAddress(context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totalAmount), isPaid: true);
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = '';

    bool isForm =
        nameController.text.isNotEmpty ||
        housenoController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        landMarkController.text.isNotEmpty ||
        pinCodeController.text.isNotEmpty ||
        phoneController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
        'Name: ${nameController.text} \n${housenoController.text}, \n${areaController.text}, \n${cityController.text}, \n${landMarkController.text} \nPin code: ${pinCodeController.text}'
            '\nContact No: ${phoneController.text}';
          addressServices.saveUserAddress(context: context, address: addressToBeUsed);
        Navigator.push(context, MaterialPageRoute(builder: (_) => PayUPIViewOrderedProducts(address: addressToBeUsed,)));
      } else {
        throw Exception('Please fill all address fields');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
      Navigator.push(context, MaterialPageRoute(builder: (_) => PayUPIViewOrderedProducts(address: addressToBeUsed,)));
    } else {
      showSnackBar(context, "Error");
    }
  }
  // void payCardPressed(String addressFromProvider) {
  //   addressToBeUsed = '';
  //
  //   bool isForm =
  //       nameController.text.isNotEmpty ||
  //       housenoController.text.isNotEmpty ||
  //       areaController.text.isNotEmpty ||
  //       cityController.text.isNotEmpty ||
  //       landMarkController.text.isNotEmpty ||
  //       pinCodeController.text.isNotEmpty ||
  //       phoneController.text.isNotEmpty;
  //
  //   if (isForm) {
  //     if (_addressFormKey.currentState!.validate()) {
  //       addressToBeUsed =
  //       'Name: ${nameController.text} \n${housenoController.text}, \n${areaController.text}, \n${cityController.text}, \n${landMarkController.text} \nPin code: ${pinCodeController.text}'
  //           '\nContact No: ${phoneController.text}';
  //         addressServices.saveUserAddress(context: context, address: addressToBeUsed);
  //       Navigator.push(context, MaterialPageRoute(builder: (_) => PayStripeViewOrderedProducts(address: addressToBeUsed,)));
  //     } else {
  //       throw Exception('Please fill all address fields');
  //     }
  //   } else if (addressFromProvider.isNotEmpty) {
  //     addressToBeUsed = addressFromProvider;
  //     Navigator.push(context, MaterialPageRoute(builder: (_) => PayStripeViewOrderedProducts(address: addressToBeUsed,)));
  //   } else {
  //     showSnackBar(context, "Error");
  //   }
  // }
  void payDeliveryPressed(String addressFromProvider) {
    addressToBeUsed = '';

    bool isForm =
        housenoController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        landMarkController.text.isNotEmpty ||
        pinCodeController.text.isNotEmpty ||
        phoneController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            'Name: ${nameController.text} \n${housenoController.text}, \n${areaController.text}, \n${cityController.text}, \n${landMarkController.text} \nPin code: ${pinCodeController.text}'
                '\nContact No: ${phoneController.text}';
          addressServices.saveUserAddress(context: context, address: addressToBeUsed);
          Navigator.push(context, MaterialPageRoute(builder: (_)=>PayDeliveryViewOrderedProducts(address: addressToBeUsed,)));
        // addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse("${widget.totalAmount}"), isPaid: false);
        // Navigator.pop(context);
      } else {
        throw Exception('Please fill all address fields');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
      Navigator.push(context, MaterialPageRoute(builder: (_)=>PayDeliveryViewOrderedProducts(address: addressToBeUsed,)));
      // addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse("${widget.totalAmount}"), isPaid: false);
      // Navigator.pop(context);
      setState(() {

      });
    } else {
      showSnackBar(context, "Error");
    }
  }


  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Provide Address", style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (address.isNotEmpty)
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Delivery to Previous Address:"),
                              Text(
                                address,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "OR",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(alignment: Alignment.topLeft, child: Text("Add New Address:", style: TextStyle(fontSize: 17),))
                    ],
                  ),
                Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      CustomTextField(controller: nameController, hintText: "Customer Name"),
                      SizedBox(height: 15),
                      CustomTextField(
                        controller: housenoController,
                        hintText: "House No., Building,",
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        controller: areaController,
                        hintText: "Area, Street",
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        controller: landMarkController,
                        hintText: "LandMark (eg: Near Ruby Nagar)",
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        controller: cityController,
                        hintText: "City, State",
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        controller: pinCodeController,
                        hintText: "Pin Code",
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        controller: phoneController,
                        hintText: "Mobile Number",
                      ),
                      Provider.of<UserProvider> (context, listen: false).user.address.isNotEmpty ?
                      Text("This will update your current address") : SizedBox(),
                      SizedBox(height: 15,)
                    ],
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(onPressed: () => payPressed(address), child: Text("Pay with UPI", style: TextStyle(color: Colors.white, fontSize: 20)), style: ElevatedButton.styleFrom(backgroundColor: AppStyle.mainColor, minimumSize: Size(double.infinity, 50),)),
                SizedBox(height: 15),
                Text("OR"),
                SizedBox(height: 15,),
                // ElevatedButton(onPressed: () => payCardPressed(address), child: Text("Pay with Card", style: TextStyle(color: Colors.white, fontSize: 20)), style: ElevatedButton.styleFrom(backgroundColor: AppStyle.mainColor, minimumSize: Size(double.infinity, 50),)),
                GooglePayButton(
                  onPressed: ()=> payPressed(address),
                  width: double.infinity,
                  paymentConfigurationAsset: 'gpay.json',
                  paymentConfiguration:
                      PaymentConfiguration.fromJsonString('gpay.json'),
                  paymentItems: paymentItems,
                  height: 50,
                  type: GooglePayButtonType.pay,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: onGooglePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                SizedBox(height: 15,),
                Text("OR"),
                SizedBox(height: 15,),
                ElevatedButton(child: Text("Pay on Delivery", style: TextStyle(color: Colors.white, fontSize: 20),), onPressed: ()=> payDeliveryPressed(address),style: ElevatedButton.styleFrom(backgroundColor: AppStyle.accentColor, minimumSize: Size(double.infinity, 50),),),
                SizedBox(height: 35,),
              ],
            )),
      ),
    );
  }
}
