import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  int _quantity = 1;
  final double _basePrice = 4.99; // Base price for the product

  int get quantity => _quantity;
  double get totalPrice => _quantity * _basePrice;

  void increment() {
    _quantity++;
    notifyListeners();
  }

  void decrement() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }
}