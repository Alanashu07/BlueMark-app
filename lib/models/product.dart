import 'dart:convert';
import 'package:bluemark/models/rating.dart';

class Product {
  late String name;
  final String category;
  final String sellername;
  final String sellerid;
  late double quantity;
  late String description;
  final List<String> images;
  late double wholesaleprice;
  late double plusmemberprice;
  late double retailprice;
  final String? id;
  final List<Rating>? rating;
  Product({
    required this.wholesaleprice,
    required this.plusmemberprice,
    required this.name,
    required this.category,
    required this.quantity,
    required this.sellername,
    required this.sellerid,
    required this.images,
    required this.retailprice,
    required this.description,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'sellername': sellername,
      'sellerid': sellerid,
      'category': category,
      'quantity': quantity,
      'images': images,
      'retailprice': retailprice,
      'wholesaleprice': wholesaleprice,
      'plusmemberprice': plusmemberprice,
      'id': id,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      sellername: map['sellername'] ?? '',
      sellerid: map['sellerid'] ?? '',
      category: map['category'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      retailprice: map['retailprice']?.toDouble() ?? 0.0,
      wholesaleprice: map['wholesaleprice']?.toDouble() ?? 0.0,
      plusmemberprice: map['plusmemberprice']?.toDouble() ?? 0.0,
      id: map['_id'],
      rating: map['ratings'] != null
          ? List<Rating>.from(
        map['ratings']?.map(
              (x) => Rating.fromMap(x),
        ),
      )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}