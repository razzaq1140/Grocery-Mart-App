import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery_mart_app/core/services/cart_service.dart';
import 'package:grocery_mart_app/core/services/favourite_service.dart';
import 'package:grocery_mart_app/core/utils/constants/app_colors.dart';
import 'package:grocery_mart_app/features/cart/cart_screen.dart';
import 'package:grocery_mart_app/features/home_screen/provider/product_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:grocery_mart_app/widgets/custom_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final int id; // Add this line
  final String imageName;
  final String description;
  final String price;
  final String name;

  const ProductDetailScreen({
    Key? key,
    required this.id, // Add this
    required this.name,
    required this.imageName,
    required this.description,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider(),
      child: ProductDetailScreenContent(
        id: id.toString(),
        imageName: imageName,
        description: description,
        price: price,
        name: name,
      ),
    );;
  }
}

class ProductDetailScreenContent extends StatefulWidget {
  final String id; // Add this
  final String imageName;
  final String description;
  final String price;
  final String name;

  const ProductDetailScreenContent({
    super.key,
    required this.id, // Add this
    required this.imageName,
    required this.description,
    required this.price,
    required this.name,
  });

  @override
  _ProductDetailScreenContentState createState() => _ProductDetailScreenContentState();
}

class _ProductDetailScreenContentState extends State<ProductDetailScreenContent> {
  int _currentIndex = 0;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final favoriteService = Provider.of<FavoriteService>(context, listen: false);
    _isFavorite = await favoriteService.isFavorite(widget.id);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final cartService = Provider.of<CartService>(context);
    final favoriteService = Provider.of<FavoriteService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        surfaceTintColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload),
            onPressed: () {},
          ),
          // Add cart icon with badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              FutureBuilder<int>(
                future: cartService.getCartCount(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data! > 0) {
                    return Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${snapshot.data}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    height: 250,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 250,
                        viewportFraction: 0.8,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: [widget.imageName, widget.imageName, widget.imageName].map((image) {
                        return Builder(
                          builder: (context) {
                            return Image.asset(
                              widget.imageName,
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: _currentIndex == index ? 20.0 : 4.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: _currentIndex == index ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '1kg, Price',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.green : null,
                        ),
                        onPressed: () async {
                          final item = FavoriteItem(
                            id: widget.id,
                            name: widget.name,
                            image: widget.imageName,
                            price: widget.price,
                            description: widget.description,
                          );
                          await favoriteService.toggleFavorite(item);
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: provider.decrement,
                          ),
                          Text(
                            '${provider.quantity}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                            onPressed: provider.increment,
                          ),
                        ],
                      ),
                      Text(
                        '\$${provider.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 20),
                  const Text(
                    'Product Detail',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Nutritions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: const [
                          Text('100g', style: TextStyle(color: Colors.grey)),
                          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Review',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.orange, size: 18),
                          Icon(Icons.star, color: Colors.orange, size: 18),
                          Icon(Icons.star, color: Colors.orange, size: 18),
                          Icon(Icons.star, color: Colors.orange, size: 18),
                          Icon(Icons.star_half, color: Colors.orange, size: 18),
                          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    color: AppColors.primary,
                    text: 'Add To Basket',
                    onPressed: () async {
                      final cartItem = CartItem(
                        id: widget.id,
                        name: widget.name,
                        image: widget.imageName,
                        price: double.parse(widget.price.replaceAll(RegExp(r'[^\d.]'), '')),
                        quantity: provider.quantity,
                      );
                      await cartService.addToCart(cartItem);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Item added to cart'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      setState(() {}); // Refresh the UI to update cart count
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}