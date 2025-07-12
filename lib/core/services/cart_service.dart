import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartItem {
  final String id;
  final String name;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}

class CartService extends ChangeNotifier {
  static const _cartKey = 'cart_items';
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  double get totalPrice => _cartItems.fold(
      0.0, (sum, item) => sum + (item.price * item.quantity));

  int get totalCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  CartService() {
    _loadCart();
  }

  /// Load cart from SharedPreferences and populate in memory
  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString(_cartKey) ?? '[]';
    final List<dynamic> cartMap = json.decode(cartJson);
    _cartItems = cartMap.map((item) => CartItem.fromMap(item)).toList();
    notifyListeners();
  }

  /// Async getter for compatibility with old code
  Future<List<CartItem>> getCartItems() async {
    if (_cartItems.isEmpty) {
      await _loadCart();
    }
    return _cartItems;
  }

  Future<void> addToCart(CartItem newItem) async {
    final existingIndex =
    _cartItems.indexWhere((item) => item.id == newItem.id);

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity += newItem.quantity;
    } else {
      _cartItems.add(newItem);
    }
    await _saveCart();
  }

  Future<void> removeFromCart(String id) async {
    _cartItems.removeWhere((item) => item.id == id);
    await _saveCart();
  }

  Future<void> updateQuantity(String id, int newQuantity) async {
    final index = _cartItems.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (newQuantity > 0) {
        _cartItems[index].quantity = newQuantity;
      } else {
        _cartItems.removeAt(index);
      }
      await _saveCart();
    }
  }

  Future<void> clearCart() async {
    _cartItems.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
    notifyListeners();
  }

  Future<int> getCartCount() async {
    if (_cartItems.isEmpty) {
      await _loadCart();
    }
    return totalCount;
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson =
    json.encode(_cartItems.map((item) => item.toMap()).toList());
    await prefs.setString(_cartKey, cartJson);
    notifyListeners();
  }

  Future<void> incrementQuantity(String id) async {
    final index = _cartItems.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _cartItems[index].quantity += 1;
      await _saveCart();
    }
  }

  Future<void> decrementQuantity(String id) async {
    final index = _cartItems.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity -= 1;
      } else {
        _cartItems.removeAt(index);
      }
      await _saveCart();
    }
  }

}
