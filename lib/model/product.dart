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
  Product(
      {required this.id,
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
      required this.price});

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map["id"] as int,
        title: map["title"] as String,
        description: map["description"] as String,
        texture: map["texture"] as String,
        wash: map["wash"] as String,
        place: map["place"] as String,
        note: map["note"] as String,
        story: map["story"] as String,
        colors: [],
        sizes: [],
        images: [],
        mainImage: map["main_image"] as String,
        price: map["price"] as int);
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
