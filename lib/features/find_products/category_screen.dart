import 'package:flutter/material.dart';

class BeveragesScreen extends StatelessWidget {
  const BeveragesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> beverages = [
      {
        'name': 'Diet Coke',
        'subtitle': '355ml, Price',
        'price': '1.99',
        'image': 'assets/images/diet_coke.png',
      },
      {
        'name': 'Sprite Can',
        'subtitle': '325ml, Price',
        'price': '1.50',
        'image': 'assets/images/sprite.png',
      },
      {
        'name': 'Apple & Grape Juice',
        'subtitle': '2L, Price',
        'price': '15.99',
        'image': 'assets/images/apple_grape_juice.png',
      },
      {
        'name': 'Orange Juice',
        'subtitle': '2L, Price',
        'price': '15.99',
        'image': 'assets/images/orange_juice.png',
      },
      {
        'name': 'Coca Cola Can',
        'subtitle': '325ml, Price',
        'price': '4.99',
        'image': 'assets/images/coca_cola.png',
      },
      {
        'name': 'Pepsi Can',
        'subtitle': '330ml, Price',
        'price': '4.99',
        'image': 'assets/images/pepsi.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Beverages',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemCount: beverages.length,
          itemBuilder: (context, index) {
            final item = beverages[index];
            return ProductCard(
              name: item['name']!,
              subtitle: item['subtitle']!,
              price: item['price']!,
              image: item['image']!,
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String price;
  final String image;

  const ProductCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              image,
              height: 80,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$$price',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add, color: Colors.white),
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
