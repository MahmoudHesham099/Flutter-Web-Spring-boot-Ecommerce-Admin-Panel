class Product {
  int? id;
  String? name;
  String? description;
  String? image;
  double? price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  Product.empty();

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson(Product product) {
    return {
      "id": product.id,
      "name": product.name,
      "description": product.description,
      "image": product.image,
      "price": product.price,
    };
  }

  @override
  String toString() {
    return 'Product{id: $id,'
        ' name: $name,'
        ' description: $description,'
        ' image: $image,'
        ' price: $price}';
  }
}
