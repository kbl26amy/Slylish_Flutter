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
      this.id,
      this.title,
      this.description,
      this.texture,
      this.wash,
      this.place,
      this.note,
      this.story,
      this.colors,
      this.sizes,
      this.images,
      this.mainImage,
      this.price);
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
