import 'package:flutter/material.dart';
import 'package:grocery_mart_app/core/services/cart_service.dart';
import 'package:grocery_mart_app/core/utils/constants/app_colors.dart';
import 'package:grocery_mart_app/core/utils/constants/app_images.dart';
import 'package:grocery_mart_app/features/cart/accept_screen.dart';
import 'package:grocery_mart_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.black),
            onPressed: () {
              context.read<CartService>().clearCart();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart cleared')),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[50],
      body: Consumer<CartService>(
        builder: (context, cartService, _) {
          final cartItems = cartService.cartItems;

          if (cartItems.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final total = cartService.totalPrice;

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: cartItems.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      leading: Image.asset(
                        item.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        item.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cartService.removeFromCart(item.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('${item.name} removed')),
                              );
                            },
                            child: const Icon(Icons.close, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '1kg, Price',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                color: Colors.green,
                                onPressed: () {
                                  cartService.decrementQuantity(item.id);
                                },
                              ),
                              Text(
                                '${item.quantity}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  cartService.incrementQuantity(item.id);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(0, -1),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        color: AppColors.primary,
                        text: 'Go to Checkout  \$${total.toStringAsFixed(2)}',
                        onPressed: () {
                          showCheckoutBottomSheet(context);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
  void showCheckoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text(
                    'Checkout',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _checkoutTile(title: 'Delivery', value: 'Select Method'),
              _checkoutTile(title: 'Pament', valueWidget: Image.asset(
                AppImages.paymentImage,
                width: 30,
                height: 20,
              )),
              _checkoutTile(title: 'Promo Code', value: 'Pick discount'),
              _checkoutTile(title: 'Total Cost', value: '\$13.97', isBold: true),

              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),

              const Text.rich(
                TextSpan(
                  text: 'By placing an order you agree to our ',
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: 'Terms And Conditions',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),

              CustomButton(
                  color: AppColors.primary,
                  text: "Place Order", onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => AcceptOrder(),));
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _checkoutTile({
    required String title,
    String? value,
    Widget? valueWidget,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          valueWidget ??
              Text(
                value ?? '',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
          const SizedBox(width: 5),
          const Icon(Icons.arrow_forward_ios_rounded, size: 14),
        ],
      ),
    );
  }

}
