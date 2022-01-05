import 'package:e_commerce_app/models/category.dart';
import 'package:flutter/cupertino.dart';

enum SubCategory {
  women,
  men,
  children,
}

class Product with ChangeNotifier {
  final String? id;
  final List<ProductCategory>? categories;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  final SubCategory? subCategory;
  bool? isFavorite;

  Product({
    this.id,
    this.categories,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.subCategory,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite!;
    notifyListeners();
  }
}