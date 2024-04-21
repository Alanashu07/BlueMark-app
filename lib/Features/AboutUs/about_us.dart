import 'package:bluemark/Pages/homescreen/widgets/carousel_image.dart';
import 'package:bluemark/Styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {

  _launchWhatsappUrl() async{
   const url = 'https://wa.me/+919895260129';
     await launchUrl(Uri.parse(url));
  }

  _launchInstagramUrl() async{
    const url = 'https://instagram.com/am_developers_tvm?igshid=YTQwZjQ0NmI0OA==';
    await launchUrl(Uri.parse(url));
  }

  _launchGmailUrl() async{
    const url = 'https://mail.google.com/mail/u/0/#inbox?compose=CllgCJZZxwjmKsjKLMtsvSVdjpZQGrBldrwLSkPKkDkCVNhTQzXvZrSlTGPFfBxFcqgMsCvtftg';
    await launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("About Us", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body:
      SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(alignment: Alignment.center, child: Image.asset('images/icon.png', scale: 5,)),
                      Container(alignment: Alignment.center,child: Text("Blue Mark", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),)),
                      Divider(height: 15, thickness: 10, color: Colors.white,)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Container(alignment: Alignment.centerLeft,child: Text("Powered By:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),),),
                      Container(alignment: Alignment.center, child: Image.asset('images/amd.png', scale: 3,)),
                      Container(alignment: Alignment.center,child: Text("AM Developers", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),)),
                      Divider(height: 15, thickness: 10, color: Colors.white,)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Under Partnership of:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Anas A", style: TextStyle(fontSize: 18),),
                        Text("+91 9895260129", style: TextStyle(fontSize: 18),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Abdulla Salam A", style: TextStyle(fontSize: 18),),
                        Text("+91 9074342730", style: TextStyle(fontSize: 18),),
                      ],
                    ),
                    Divider(height: 15, thickness: 3,color: Colors.white,),
                    // SizedBox(height: 10,),
                    CarouselImage(),
                    // SizedBox(height: 15,),
                    Divider(height: 15, thickness: 3,color: Colors.white,),
                    Container(alignment: Alignment.center, child: Text("App Development & E-Commerce", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),),
                    Divider(height: 15, thickness: 3,color: Colors.white,),
                    Text("Contact Us on:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: _launchWhatsappUrl,
                            child: Image.asset('images/whatsapp.png', scale: 5,)),
                        GestureDetector(
                            onTap: _launchInstagramUrl,
                            child: Image.asset('images/instagram.png', scale: 5,)),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Container(width: double.infinity, child: Text("OR", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                    Container(width: double.infinity, child: Text("E-Mail Us:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),textAlign: TextAlign.center,)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: _launchGmailUrl,
                            child: Image.asset('images/gmail.png', scale: 5,)),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("am.developerstvm@gmail.com"),
                            Text("alanashu07@gmail.com"),
                            Text("abdulla.salam1112@gmail.com"),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 50,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
