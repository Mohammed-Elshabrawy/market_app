import 'package:flutter/material.dart';
import 'package:market_app/shared/network/remoote/supabase_key.dart';
import 'package:market_app/shared/styles/style.dart';
import 'modules/navbar/ui/main_home_screen.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );
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
      home: const MainHomeScreen(),
    );
  }
}

