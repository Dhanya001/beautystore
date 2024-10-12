import 'package:flutter/material.dart';
import 'package:mansi_beauty_store/Modules/Products_Model.dart';

class Products with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}