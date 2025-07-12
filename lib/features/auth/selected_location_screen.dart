import 'package:flutter/material.dart';
import 'package:grocery_mart_app/core/utils/constants/app_colors.dart';
import 'package:grocery_mart_app/core/utils/constants/app_images.dart';
import 'package:grocery_mart_app/widgets/custom_button.dart';

class SelectLocationScreen extends StatefulWidget {
  static const String routeName = '/select_location_screen';

  const SelectLocationScreen({super.key});

  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  String selectedZone = 'Banarseee';
  String selectedArea = 'Types of your area';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.selectLocationImage,
              height: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Select Your Location',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Switch on your location to stay in tune\nwith what\'s happening in your area',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 70),

            // Zone Dropdown
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Zone',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            DropdownButtonFormField<String>(
              value: selectedZone,
              icon: const Icon(Icons.arrow_drop_down),
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.zero,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.zero,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedZone = newValue!;
                });
              },
              items: ['Banarseee', 'Zone 1', 'Zone 2', 'Zone 3']
                  .map((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
                  .toList(),
            ),
            const SizedBox(height: 20),

            // Area Dropdown
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Area',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            DropdownButtonFormField<String>(
              value: selectedArea,
              icon: const Icon(Icons.arrow_drop_down),
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.zero,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.zero,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedArea = newValue!;
                });
              },
              items: ['Types of your area', 'Area 1', 'Area 2', 'Area 3']
                  .map((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
                  .toList(),
            ),
            const SizedBox(height: 30),

            // Submit Button
            CustomButton(
              text: 'Submit',
              color: AppColors.primary,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/logIn');
              },
            ),
          ],
        ),
      ),
    );
  }
}
