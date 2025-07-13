import 'package:flutter/material.dart';
import 'package:grocery_mart_app/core/utils/constants/app_colors.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class MobileNumberScreen extends StatelessWidget {
  static const String routeName = '/mobile_number_screen';

  const MobileNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your mobile number',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Mobile Number',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: 8),
            IntlPhoneField(
              decoration: InputDecoration(
                hintText: '1XXXXXXXXX',
                hintStyle: const TextStyle(fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 1.2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
              ),
              initialCountryCode: 'BD',
              onChanged: (phone) {
                debugPrint(phone.completeNumber);
              },
              disableLengthCheck: true,
              style: const TextStyle(fontSize: 16),
              dropdownTextStyle: const TextStyle(fontSize: 16, color: AppColors.black),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/verification');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.all(18),
                  ),
                  child: const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}