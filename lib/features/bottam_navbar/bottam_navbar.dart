import 'package:flutter/material.dart';
import 'package:grocery_mart_app/core/utils/constants/app_colors.dart';
import 'package:grocery_mart_app/features/account/account_screen.dart';
import 'package:grocery_mart_app/features/cart/cart_screen.dart';
import 'package:grocery_mart_app/features/favourite/favourite_screen.dart';
import 'package:grocery_mart_app/features/find_products/find_products_screen.dart';
import 'package:grocery_mart_app/features/home_screen/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = '/bottam_navbar';

  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FindProductsScreen(),
    CartScreen(),
    FavoriteScreen(),
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
        items:  <BottomNavigationBarItem>[
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
        unselectedItemColor: AppColors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}