import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsparktask/const/assets.dart';
import 'package:itsparktask/const/colors.dart';
import 'package:itsparktask/ui/home_screen.dart';
import 'package:itsparktask/ui/login_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: AppColors.backGroundColor,
      duration: const Duration(seconds: 1),
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.fullLogo),
           SizedBox(height: 20.h),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            backgroundColor: AppColors.secondaryColor,
          ),
        ],
      ),
      onInit: () async {
        
      },
      onAnimationEnd: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        print(pref.getString("token"));
        
        Navigator.pushReplacement(
          context,
          pref.getString("token") != null && pref.getString("token") != "" ? MaterialPageRoute(builder: (context) => const HomeScreen())  : MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
      // Uncomment to perform async tasks before navigating
      // asyncNavigationCallback: () async {
      //   await someAsyncTask();
      // },
      // nextScreen: const LoginScreen(), // Removed to use onAnimationEnd for navigation
    );
  }
}
