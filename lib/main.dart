import 'package:flutter/material.dart';
import 'package:grocery_mart_app/core/services/cart_service.dart';
import 'package:grocery_mart_app/core/services/favourite_service.dart';
import 'package:grocery_mart_app/features/auth/login_screen.dart';
import 'package:grocery_mart_app/features/auth/mobile_number_screen.dart';
import 'package:grocery_mart_app/features/auth/selected_location_screen.dart';
import 'package:grocery_mart_app/features/auth/sign_in_screen.dart';
import 'package:grocery_mart_app/features/auth/signup_screen.dart';
import 'package:grocery_mart_app/features/auth/verification_screen.dart';
import 'package:grocery_mart_app/features/bottam_navbar/bottam_navbar.dart';
import 'package:grocery_mart_app/features/home_screen/provider/home_screen_provider.dart';
import 'package:grocery_mart_app/features/onbarding/onbarding_screen.dart';
import 'package:grocery_mart_app/features/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => HomeProvider(),),
      ChangeNotifierProvider(create: (context) => FavoriteService(),),
      ChangeNotifierProvider(
        create: (_) => CartService(),
      ),
    ],child: MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: BottomNavBar.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        OnboardingScreen.routeName: (context) =>  OnboardingScreen(),
        SignScreen.routeName: (context) =>  SignScreen(),
        MobileNumberScreen.routeName: (context) =>  MobileNumberScreen(),
        VerificationScreen.routeName: (context) => const VerificationScreen(),
        SelectLocationScreen.routeName: (context) => const SelectLocationScreen(),
        LoginScreen.routeName: (context) =>  LoginScreen(),
        SignupScreen.routeName: (context) =>  SignupScreen(),
        BottomNavBar.routeName: (context) =>  BottomNavBar(),
      },
    ),);
  }
}