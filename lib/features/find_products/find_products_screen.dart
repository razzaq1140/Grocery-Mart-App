import 'package:flutter/material.dart';
import 'package:grocery_mart_app/core/utils/constants/app_colors.dart';
import 'package:grocery_mart_app/core/utils/constants/app_images.dart';

class FindProductsScreen extends StatefulWidget {
  static const String routeName = 'find_product';
  const FindProductsScreen({super.key});

  @override
  State<FindProductsScreen> createState() => _FindProductsScreenState();
}

class _FindProductsScreenState extends State<FindProductsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> allCategories = [
    {
      'title': 'Frash Fruits & Vegetable',
      'image': AppImages.image_1,
      'color': AppColors.primary,
    },
    {
      'title': 'Cooking Oil & Ghee',
      'image': AppImages.image_2,
      'color': Colors.orange.shade50,
    },
    {
      'title': 'Meat & Fish',
      'image': AppImages.image_3,
      'color': AppColors.errorRed,
    },
    {
      'title': 'Bakery & Snacks',
      'image': AppImages.image_4,
      'color': Colors.brown.shade50,
    },
    {
      'title': 'Dairy & Eggs',
      'image': AppImages.image_1,
      'color': Colors.yellow.shade50,
    },
    {
      'title': 'Beverages',
      'image': AppImages.image_5,
      'color': Colors.blue.shade50,
    },
  ];

  late List<Map<String, dynamic>> filteredCategories;

  @override
  void initState() {
    super.initState();
    filteredCategories = allCategories;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCategories = allCategories.where((category) {
        final title = category['title'].toString().toLowerCase();
        return title.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        centerTitle: true,
        title: const Text(
          'Find Products',
          style: TextStyle(color: AppColors.black),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search Store',
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Grid
              Expanded(
                child: filteredCategories.isEmpty
                    ? const Center(
                  child: Text(
                    'No products found',
                    style: TextStyle(color: AppColors.grey),
                  ),
                )
                    : GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                    final category = filteredCategories[index];
                    return CategoryCard(
                      title: category['title'],
                      image: category['image'],
                      bgColor: category['color'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final Color bgColor;

  const CategoryCard({
    super.key,
    required this.title,
    required this.image,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Image.asset(image),
          ),
          const SizedBox(height: 8),
          Expanded(
            flex: 3,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
