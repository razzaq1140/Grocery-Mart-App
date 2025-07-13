import 'package:flutter/material.dart';
import 'package:grocery_mart_app/core/utils/constants/app_colors.dart';
import 'package:grocery_mart_app/core/utils/constants/app_images.dart';
import 'package:grocery_mart_app/features/home_screen/product_detail_screen.dart';
import 'package:grocery_mart_app/features/home_screen/provider/product_detail_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String query = '';

  final List<Map<String, dynamic>> exclusiveOffers = [
    {
      'name': 'Organic Bananas',
      'id': 1,
      'description': '7pcs, Price',
      'price': '\$4.99',
      'image': AppImages.bananaImage,
    },
    {
      'name': 'Red Apple',
      'id': 2,
      'description': '1kg, Price',
      'price': '\$4.99',
      'image': AppImages.appleImage,
    },
  ];

  final List<Map<String, dynamic>> bestSelling = [
    {
      'name': 'Red Bell Pepper',
      'description': '',
      'id': 3,
      'price': '\$3.99',
      'image': AppImages.pngfuel_1Image,
    },
    {
      'name': 'Fresh Ginger',
      'id': 4,
      'description': '',
      'price': '\$2.99',
      'image': AppImages.pngfuel_2Image,
    },
  ];

  final List<Map<String, dynamic>> groceriesItems = [
    {
      'name': 'Beef Bone',
      'id': 5,
      'description': '1kg, Price',
      'price': '\$4.99',
      'image': AppImages.pngfuel_3Image,
    },
    {
      'name': 'Broiler Chicken',
      'id': 6,
      'description': '1kg, Price',
      'price': '\$4.99',
      'image': AppImages.pngfuel_4Image,
    },
  ];

  List<Map<String, dynamic>> filterList(List<Map<String, dynamic>> list) {
    if (query.isEmpty) return list;
    return list
        .where((item) =>
        item['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(Icons.location_on, color: AppColors.grey),
            SizedBox(width: 5),
            Text('Dhaka, Banassree', style: TextStyle(color: AppColors.black)),
            Spacer(),
            Image.asset(AppImages.carrotImages, color: AppColors.errorRed, height: 24),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Store',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.grey,
              ),
            ),
            SizedBox(height: 20),

            /// Banner remains unchanged
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.bannerImage),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Fresh Vegetables\nGet Up To 40% OFF',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            sectionTitle('Exclusive Offer'),
            buildGrid(filterList(exclusiveOffers)),

            sectionTitle('Best Selling'),
            buildGrid(filterList(bestSelling)),

            sectionTitle('Groceries'),
            buildGrid(filterList(groceriesItems)),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {},
            child: Text('See all', style: TextStyle(color: Color(0xFF4CAF50))),
          ),
        ],
      ),
    );
  }

  Widget buildGrid(List<Map<String, dynamic>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (_) => ProductProvider(),
                  child: ProductDetailScreen(
                    imageName: item['image'],
                    description: item['description'],
                    price: item['price'],
                    name: item['name'],
                    id: item['id'],
                  ),
                ),
              ),
            );
          },
          child: Card(
            elevation: 2,
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(item['image'], fit: BoxFit.cover),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(item['description'], style: TextStyle(color: AppColors.grey)),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item['price'], style: TextStyle(fontWeight: FontWeight.bold)),
                          CircleAvatar(
                            backgroundColor: Color(0xFF4CAF50),
                            child: Icon(Icons.add, color: AppColors.white, size: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}