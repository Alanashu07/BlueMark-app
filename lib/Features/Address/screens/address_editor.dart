import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Common/widgets/custom_button.dart';
import '../../../Common/widgets/custom_textfield.dart';
import '../../../providers/user_provider.dart';
import '../services/address_services.dart';

class AddressEditorScreen extends StatefulWidget {
  const AddressEditorScreen({super.key});

  @override
  State<AddressEditorScreen> createState() => _AddressEditorScreenState();
}

class _AddressEditorScreenState extends State<AddressEditorScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController housenoController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController landMarkController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  String addressToBeUsed = '';

  final AddressServices addressServices = AddressServices();

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

  void updatePressed(){
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
          Navigator.pop(context);
        } else {
          throw Exception('Please fill all address fields');
        }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Edit your Address", style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
      child: Padding(
      padding: const EdgeInsets.all(8.0),
      child:
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
                SizedBox(height: 15,),
                CustomButton(text: 'Update Address', onTap: (){
                  updatePressed();
                }),
                SizedBox(height: 20,)
              ],
            ),
          ),
      ),
    ));
  }
}
