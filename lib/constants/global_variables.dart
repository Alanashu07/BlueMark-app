import 'package:flutter/material.dart';

import '../Styles/app_style.dart';

String uri = 'https://blue-mark-server.onrender.com';
// String uri = 'http://192.168.1.82:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color(0xff000633),
      Color.fromARGB(255, 0, 101, 162),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(15, 122, 29, 1.0);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = AppStyle.accentColor;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://res.cloudinary.com/diund1rdq/image/upload/v1694448575/About%20Us/fohqbsch5jlkk5yqbw5n.jpg',
    'https://res.cloudinary.com/diund1rdq/image/upload/v1694448597/About%20Us/i8b8awwex3plbmf6c3rc.jpg',
    'https://res.cloudinary.com/diund1rdq/image/upload/v1694796374/About%20Us/eejviz9u6zcd4v8clbr7.jpg'
  ];

  //category images

static const List<Map<String, String>> categoryImages = [
  {'title': 'Watches', 'image': 'images/wristwatch.png'},
  {'title': 'Key Chain', 'image': 'images/room-key.png'},
  {'title': 'Headphones', 'image': 'images/headphones.png'},
  {'title': 'Speakers', 'image': 'images/loud-speaker.png'},
  {'title': 'Electronics', 'image': 'images/device.png'},
  {'title': 'Cosmetics', 'image': 'images/cosmetics.png'},
  {'title': 'Appliances', 'image': 'images/electric-appliance.png'},
  {'title': 'Shirts', 'image': 'images/shirt.png'},
  {'title': 'T-Shirts', 'image': 'images/tshirt.png'},
  {'title': 'Gents Wear', 'image': 'images/business-man.png'},
  {'title': 'Ladies Wear', 'image': 'images/woman.png'},
  {'title': 'Foot Wear', 'image': 'images/shoes.png'},
  {'title': 'Vegetables', 'image': 'images/vegetable.png'},
  {'title': 'Fruits', 'image': 'images/fruit.png'},
  {'title': 'Bakery Items', 'image': 'images/bread.png'},
];

}