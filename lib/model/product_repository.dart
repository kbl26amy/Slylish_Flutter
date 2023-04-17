import 'package:dio/dio.dart';
import 'product.dart';
import 'dart:developer';

abstract class IProductRepository {
  Future<ProductListResponse> fetchProductList(CategoryType type);
}

class ProductRepository extends IProductRepository {
  @override
  Future<ProductListResponse> fetchProductList(CategoryType type) async {
    Dio dio = Dio();
    try {
      var endpoint = "";
      switch (type) {
        case CategoryType.female:
          endpoint = "/products/women";
          break;
        case CategoryType.male:
          endpoint = "/products/men";
          break;
        case CategoryType.accessory:
          endpoint = "/products/accessories";
          break;
      }

      Response response =
          await dio.get("https://api.appworks-school.tw/api/1.0$endpoint");

      if (response.statusCode == 200) {
        var productList = (response.data["data"] as List<dynamic>)
            .map((product) => Product.fromJson(product as Map<String, dynamic>))
            .toList();
        return ProductListResponse(
            response.statusCode, response.statusMessage, productList);
      } else {
        log(response.statusCode.toString() + response.statusMessage.toString());
        return ProductListResponse(
            response.statusCode, response.statusMessage, []);
      }
    } catch (e) {
      log(e.toString());
      return ProductListResponse(9999, e.toString(), []);
    }
  }
}

abstract class IApiResponse {
  IApiResponse(this.code, this.message);

  final int? code;
  final String? message;
}

class ProductListResponse extends IApiResponse {
  ProductListResponse(super.code, super.message, this.productList);

  final List<Product> productList;
}

enum CategoryType { female, male, accessory }
