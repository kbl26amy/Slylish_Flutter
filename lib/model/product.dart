class Product {
  final int id;
  final String title;
  final String description;
  final String texture;
  final String wash;
  final String place;
  final String note;
  final String story;
  final List<ProductColor> colors;
  final List sizes;
  final String mainImage;
  final List images;
  final int price;
  final List<Variants> variants;

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
        colors: (json["colors"] as List<dynamic>)
            .map((color) => ProductColor.fromJson(color))
            .toList(),
        sizes: json["sizes"],
        images: json['images'],
        mainImage: json["main_image"],
        variants: (json["variants"] as List<dynamic>)
            .map((color) => Variants.fromJson(color))
            .toList(),
        price: json["price"]);
  }
}

class Variants {
  final String color;
  final String size;
  final int stock;

  Variants({
    required this.color,
    required this.size,
    required this.stock,
  });

  factory Variants.fromJson(Map<String, dynamic> json) {
    return Variants(
        color: json["color_code"], size: json["size"], stock: json["stock"]);
  }
}

class ProductColor {
  String name;
  String code;

  ProductColor({required this.name, required this.code});

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    return ProductColor(name: json["name"], code: json["code"]);
  }
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
