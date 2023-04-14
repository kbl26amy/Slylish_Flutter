import 'dart:convert';
import 'package:dio/dio.dart';
import 'product.dart';

void fetchFemaleData() async {
  Dio dio = Dio();
  try {
    Response response =
        await dio.get('https://api.appworks-school.tw/api/1.0/products/women');
    if (response.statusCode == 200) {
      StylishCategory femaleDataProduct = jsonDecode(response.data);
      print(femaleDataProduct);
    } else {
      print('fail');
    }
  } catch (e) {
    print('fail: $e');
  }
}
