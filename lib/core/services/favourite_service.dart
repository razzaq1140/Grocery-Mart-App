import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteItem {
  final String id;
  final String name;
  final String image;
  final String price;
  final String description;

  FavoriteItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'description': description,
    };
  }

  factory FavoriteItem.fromMap(Map<String, dynamic> map) {
    return FavoriteItem(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      price: map['price'],
      description: map['description'],
    );
  }
}

class FavoriteService extends ChangeNotifier {
  static const _favoriteKey = 'favorite_items';
  List<FavoriteItem> _favoriteItems = [];

  List<FavoriteItem> get favoriteItems => _favoriteItems;

  FavoriteService() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJson = prefs.getString(_favoriteKey) ?? '[]';
    final List<dynamic> favoriteMap = json.decode(favoriteJson);
    _favoriteItems = favoriteMap.map((item) => FavoriteItem.fromMap(item)).toList();
    notifyListeners();
  }

  Future<List<FavoriteItem>> getFavoriteItems() async {
    if (_favoriteItems.isEmpty) {
      await _loadFavorites();
    }
    return _favoriteItems;
  }

  Future<bool> isFavorite(String id) async {
    if (_favoriteItems.isEmpty) {
      await _loadFavorites();
    }
    return _favoriteItems.any((item) => item.id == id);
  }

  Future<void> addToFavorites(FavoriteItem item) async {
    if (!_favoriteItems.any((favItem) => favItem.id == item.id)) {
      _favoriteItems.add(item);
      await _saveFavorites();
    }
  }

  Future<void> removeFromFavorites(String id) async {
    _favoriteItems.removeWhere((item) => item.id == id);
    await _saveFavorites();
  }

  Future<void> toggleFavorite(FavoriteItem item) async {
    if (await isFavorite(item.id)) {
      await removeFromFavorites(item.id);
    } else {
      await addToFavorites(item);
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJson = json.encode(_favoriteItems.map((item) => item.toMap()).toList());
    await prefs.setString(_favoriteKey, favoriteJson);
    notifyListeners();
  }
}