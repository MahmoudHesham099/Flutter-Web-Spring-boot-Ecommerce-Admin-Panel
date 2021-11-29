import 'package:flutter/material.dart';

class Product {
  int _id;
  String _name;
  String _description;
  String _image;
  double _price;

  Product({
    required id,
    required name,
    required description,
    required image,
    required price,
  })  : _id = id,
        _name = name,
        _description = description,
        _image = image,
        _price = price;



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
      "id": product._id,
      "name": product._name,
      "description": product._description,
      "image": product._image,
      "price": product._price,
    };
  }

  double get price => _price;

  String get image => _image;

  String get description => _description;

  String get name => _name;

  int get id => _id;

  set price(double value) {
    _price = value;
  }

  set image(String value) {
    _image = value;
  }

  set description(String value) {
    _description = value;
  }

  set name(String value) {
    _name = value;
  }

  set id(int value) {
    _id = value;
  }
}
