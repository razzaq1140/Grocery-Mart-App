import 'package:flutter/material.dart';
import 'package:grocery_mart_app/core/utils/constants/app_colors.dart';
import 'package:grocery_mart_app/core/utils/constants/app_images.dart';
import 'package:grocery_mart_app/widgets/custom_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignScreen extends StatelessWidget {
  static const String routeName = '/signIn';

  const SignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppImages.nectarLogoImage,
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Get your groceries\nwith nectar',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    IntlPhoneField(
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        labelStyle: const TextStyle(color: AppColors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.grey, width: 1),
                          borderRadius: BorderRadius.zero,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.grey, width: 1.2),
                          borderRadius: BorderRadius.zero,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 12,
                        ),
                      ),
                      initialCountryCode: 'BD',
                      onChanged: (phone) {
                        debugPrint(phone.completeNumber);
                      },
                      disableLengthCheck: true,
                      style: const TextStyle(fontSize: 16),
                      dropdownTextStyle: const TextStyle(
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.grey,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or connect with social media',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.grey,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    CustomButton(
                      text: 'Continue with Google',
                      iconPath: AppImages.googleImage,
                      color: const Color(0XFF5383EC),
                      textColor: AppColors.white,
                      onPressed: () {
                        debugPrint('Google sign-in');
                        Navigator.pushNamed(context, '/mobile_number_screen');
                      },
                    ),
                    const SizedBox(height: 12),

                    CustomButton(
                      text: 'Continue with Facebook',
                      iconPath: AppImages.facebookImage,
                      color: const Color(0xFF4A66AC),
                      textColor: AppColors.white,
                      onPressed: () {
                        debugPrint('Facebook sign-in');
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
