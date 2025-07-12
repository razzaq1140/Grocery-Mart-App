import 'package:flutter/material.dart';
import 'package:grocery_mart_app/core/utils/constants/app_images.dart';
import 'package:grocery_mart_app/widgets/custom_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignScreen extends StatelessWidget {
  static const String routeName = '/signIn';

  const SignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🟢 Image full-width, top of SafeArea
              Image.asset(
                AppImages.nectarLogoImage,
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.4, // ~40% of screen
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
                          color: Colors.black87,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    IntlPhoneField(
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                          borderRadius: BorderRadius.zero,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600, width: 1.2),
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
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or connect with social media',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
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
                      textColor: Colors.white,
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
                      textColor: Colors.white,
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
