import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:products/model/product.dart';

class ProductService {
  static Future <Map> getProducts(int page) async{
    final response = await http.get("http://roocket.org/api/products?page=${page}");
    if(response.statusCode == 200){
      var responseBody = json.decode(response.body)['data'];

      List<Products> products=[];
    responseBody['data'].forEach((item){
      products.add(Products.fromjson(item));

    });

    return{
      "curent_page": responseBody['curent_page'],
      "products": products
    };
  }
  }
}
