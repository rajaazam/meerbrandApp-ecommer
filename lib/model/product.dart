import 'package:flutter/material.dart';

class Product {
  final String? name;
  final String? image;
  final dynamic price;
  final String? description;
  Product({@required this.image, @required this.name, this.description, @required this.price});
}