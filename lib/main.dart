import 'package:flutter/material.dart';
import 'package:market_app/shared/styles/style.dart';

import 'moudules/auth/login_screen/login_screen.dart';

void main() {
  runApp(const Market());
}

class Market extends StatelessWidget {
  const Market({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Market App',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.kScaffoldColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
    );
  }
}

