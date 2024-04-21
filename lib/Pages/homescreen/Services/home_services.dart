import 'dart:convert';
import 'dart:io';
import 'package:bluemark/models/user.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });

      httpErrorHandle(response: res, context: context, onSuccess: () {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<List<Product>> fetchProductsSeller({required BuildContext context, required String sellerid}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/api/products?sellerid=$sellerid'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });

      httpErrorHandle(response: res, context: context, onSuccess: () {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }


  Future<List<Product>> fetchSellerProducts({required BuildContext context, required String sellerid}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.post(
          Uri.parse('$uri/api/products-seller'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      },
          body: jsonEncode({'sellerid': sellerid})
      );

      httpErrorHandle(response: res, context: context, onSuccess: () {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void outOfStock(
      {
        required BuildContext context,
        required Product product,
        required VoidCallback onSuccess
      }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/out-of-stock'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({'id': product.id})
      );

      httpErrorHandle(response: res, context: context, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required String sellername,
    required String sellerid,
    required double retailprice,
    required double wholesaleprice,
    required double plusmemberprice,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('diund1rdq', 'yfzrwfpl');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        category: category,
        quantity: quantity,
        images: imageUrls,
        retailprice: retailprice,
        wholesaleprice: wholesaleprice,
        plusmemberprice: plusmemberprice,
        sellername: sellername,
        sellerid: sellerid,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: product.toJson(),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product added Successfully!');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void deleteProduct(
      {required BuildContext context,
        required Product product,
        required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({'id': product.id}),
      );

      httpErrorHandle(response: res, context: context, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  Future<List<Product>> fetchProductsUser(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res =
      await http.get(Uri.parse('$uri/api/get-products'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }


  void updateProduct(
      {required BuildContext context,
        required Product product,
        required VoidCallback onSuccess,
        required String name,
        required String description,
        required double retailprice,
        required double wholesaleprice,
        required double plusmemberprice,
        required double quantity,
      }
      ) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/update-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({'id': product.id, 'name': product.name, 'description': product.description, 'quantity': product.quantity, 'retailprice': product.retailprice, 'wholesaleprice': product.wholesaleprice, 'plusmemberprice': product.plusmemberprice}),
      );
      httpErrorHandle(response: res, context: context, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void UpdateUserInfo({required BuildContext context, required String name, required User user, required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/update-user'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      }, body: jsonEncode({'id': user.id, 'name': user.name}));
      httpErrorHandle(response: res, context: context, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Product> fetchDealOfDay({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(name: '', description: '', category: '', quantity: 0, images: [], retailprice: 0, wholesaleprice: 0, plusmemberprice: 0, sellername: '', sellerid: '');
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });

      httpErrorHandle(response: res, context: context, onSuccess: () {
        product = Product.fromJson(res.body);
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}