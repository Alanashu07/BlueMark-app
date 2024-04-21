import 'package:bluemark/Admin/Screens/orders_screen.dart';
import 'package:bluemark/Admin/Services/admin_services.dart';
import 'package:bluemark/Common/widgets/loader.dart';
import 'package:bluemark/Styles/app_style.dart';
import 'package:flutter/material.dart';

import '../model/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async{
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null ? Loader() : Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Total Sales Through Blue Mark:  ₹$totalSales", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 30,),
          Text("Dues: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
