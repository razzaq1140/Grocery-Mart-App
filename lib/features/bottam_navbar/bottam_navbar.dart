import 'package:flutter/material.dart';
import 'package:grocery_mart_app/core/services/cart_service.dart';
import 'package:grocery_mart_app/features/account/account_screen.dart';
import 'package:grocery_mart_app/features/cart/cart_screen.dart';
import 'package:grocery_mart_app/features/find_products/find_products_screen.dart';
import 'package:grocery_mart_app/features/home_screen/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = '/bottam_navbar';

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FindProductsScreen(),
    CartScreen(),
    const Text('Favourite Screen', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF4CAF50),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}