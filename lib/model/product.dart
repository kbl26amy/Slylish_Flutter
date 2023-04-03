class Product {
  String id = "";
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
  String price = "";
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
