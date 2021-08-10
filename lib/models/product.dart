class ProductData {
  List<Product> products;

  ProductData(this.products);
}

class Product {
  int id;
  String name;
  String description;
  double weight;
  String material;
  List<String> image;
  int quantity;
  double price;
  int stock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.weight,
    required this.material,
    required this.image,
    required this.quantity,
    required this.price,
    required this.stock,
  });
}
