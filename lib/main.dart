import 'package:flutter/material.dart';
import 'package:market_app/moudules/auth/ui/login.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Login(),
    );
  }
}

