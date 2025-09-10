import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mbaaza_pay/core/constants/colors.dart';
import 'package:mbaaza_pay/features/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mbaaza Pay',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFF1F1F3),
          fontFamily: GoogleFonts.figtree().fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
