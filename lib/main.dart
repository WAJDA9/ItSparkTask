import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itsparktask/const/colors.dart';
import 'package:itsparktask/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouter _router;
  @override
  void initState() {
    _router = AppRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: SafeArea(
        child: MaterialApp(
          color: AppColors.primaryColor,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: NoTransitionPageTransitionsBuilder(),
                TargetPlatform.iOS: NoTransitionPageTransitionsBuilder(),
              },
            ),
            fontFamily: GoogleFonts.inter().fontFamily,
            scaffoldBackgroundColor: AppColors.backGroundColor,
          ),
          title: 'Physio App',
          onGenerateRoute: _router.onGenerateRoute,
        ),
      ),
    );
  }
}

class NoTransitionPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // No transition effect
    return child;
  }
}
