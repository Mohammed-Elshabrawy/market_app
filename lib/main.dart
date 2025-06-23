import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/modules/auth/login_screen/login_screen.dart';
import 'package:market_app/modules/navbar/ui/main_home_screen.dart';
import 'package:market_app/shared/bloc_observer.dart';
import 'package:market_app/shared/network/remote/supabase_key.dart';
import 'package:market_app/shared/styles/style.dart';
import 'modules/auth/logic/authentication_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main()  async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );
  runApp(const Market());
}

class Market extends StatelessWidget {
  const Market({super.key});

  @override
  Widget build(BuildContext context) {
    SupabaseClient clint = Supabase.instance.client;
    return BlocProvider(
      create: (BuildContext context)=>AuthenticationCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Market App',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.kScaffoldColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home:clint.auth.currentUser!=null? MainHomeScreen(): const LoginScreen(),
      ),
    );
  }
}

