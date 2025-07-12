import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  String _query = '';

  String get query => _query;

  set query(String value) {
    _query = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> filter(List<Map<String, dynamic>> items) {
    if (_query.isEmpty) return items;

    return items.where((item) =>
        item['name'].toLowerCase().contains(_query.toLowerCase())
    ).toList();
  }
}
