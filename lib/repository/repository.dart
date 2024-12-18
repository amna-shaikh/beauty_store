import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:beauty_store/models/product_model.dart';
import 'package:beauty_store/utils/app_constant.dart';

class Repository {
  Map<String, String> headers = {
    'Authorization': "",
    'user_id': "",
    'Content-Type': 'application/json',
    'Charset': 'utf-8',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': "*",
  };

  Future<List<ProductModel>?> getProducts() async {
    try {
      var url = Uri.parse(AppConstant.getAllProducts);
      final response = await http.get(url, headers: headers);

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data != null) {
          List<ProductModel> parsedData = (data as List).map((item) {
            return ProductModel.fromJson(item);
          }).toList();

          AppConstant.products = parsedData;
          AppConstant.filterProducts = parsedData;
          return parsedData;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
