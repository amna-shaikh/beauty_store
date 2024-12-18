import 'dart:ui';

import 'package:beauty_store/models/product_model.dart';

class AppConstant {
  static String baseUrl = "https://fakestoreapi.com";
  static String getAllProducts = "$baseUrl/products?limit=50";

  static Color containerColor = const Color(0xffCACACA);
  static Color appBarColor = const Color(0xff7A6EAE);
 
  

  //static Future<List<ProductModel>?> list =[];
  static List<ProductModel> products = [];
  static List<ProductModel> filterProducts = [];
  static bool isFilter = false;
  static bool isPriceFilter1 = false;
  static bool isPriceFilter2 = false;

}
