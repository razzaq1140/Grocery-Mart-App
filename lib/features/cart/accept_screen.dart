import 'package:flutter/material.dart';
import 'package:grocery_mart_app/core/utils/constants/app_colors.dart';
import 'package:grocery_mart_app/core/utils/constants/app_images.dart';
import 'package:grocery_mart_app/widgets/custom_button.dart';

class AcceptOrder extends StatelessWidget {
  const AcceptOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),

            Image.asset(
              AppImages.acceptOrderImage, // Make sure path is correct
              height: 160,
            ),

            const SizedBox(height: 40),

            const Text(
              'Your Order has been\naccepted',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Your items has been placed and is on\nit’s way to being processed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const Spacer(flex: 3),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(color: AppColors.primary,text: 'Track Order', onPressed: (){}),
            ),

            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {
                // Navigate to home
              },
              child: const Text(
                'Back to home',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
