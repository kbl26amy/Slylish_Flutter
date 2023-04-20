import 'package:flutter/material.dart';

class Product {
  int id = 0;
  String title = "";
  String description = "";
  String texture = "";
  String wash = "";
  String place = "";
  String note = "";
  String story = "";
  List colors = [];
  List sizes = [];
  String mainImage = "";
  List images = [];
  int price = 0;
  List variants = [];

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.texture,
    required this.wash,
    required this.place,
    required this.note,
    required this.story,
    required this.colors,
    required this.sizes,
    required this.images,
    required this.mainImage,
    required this.price,
    required this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        texture: json["texture"],
        wash: json["wash"],
        place: json["place"],
        note: json["note"],
        story: json["story"],
        colors: json["colors"],
        sizes: json["sizes"],
        images: json['images'],
        mainImage: json["main_image"],
        variants: json["variants"],
        price: json["price"]);
  }
}

class Variants {
  String color = "";
  String size = "";
  String stock = "";
}

class ClothesColors {
  String name = "";
  String code = "";

  // factory ClothesColors.fromDynamic(dynamic color) {
  //   return ClothesColors
  // }
}

class StylishCategory {
  String category = "";
  List<Product> productList = <Product>[];

  StylishCategory(this.category, this.productList);
}

class HomePageViewEntity {
  StylishCategory femaleCategory = StylishCategory("女裝", <Product>[]);
  StylishCategory maleCategory = StylishCategory("男裝", <Product>[]);
  StylishCategory acceCategory = StylishCategory("配件", <Product>[]);

  void updateFemaleList(List<Product> list) {
    femaleCategory.productList.clear();
    femaleCategory.productList.addAll(list);
  }

  void updateMaleList(List<Product> list) {
    maleCategory.productList.clear();
    maleCategory.productList.addAll(list);
  }

  void updateAcceList(List<Product> list) {
    acceCategory.productList.clear();
    acceCategory.productList.addAll(list);
  }
}
