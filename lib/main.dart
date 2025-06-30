import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/modules/auth/login_screen/login_screen.dart';
import 'package:market_app/shared/bloc_observer.dart';
import 'package:market_app/shared/components/custom_indicator.dart';
import 'package:market_app/shared/network/remote/supabase_key.dart';
import 'package:market_app/shared/styles/style.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'layout/navbar/ui/main_home_screen.dart';
import 'modules/auth/logic/authentication_cubit.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: url, anonKey: anonKey);
  runApp(
    BlocProvider(
      create: (BuildContext context) => AuthenticationCubit()..getUserData(),
      child: const Market(),
    ),
  );
}

class Market extends StatelessWidget {
  const Market({super.key});

  @override
  Widget build(BuildContext context) {
    SupabaseClient clint = Supabase.instance.client;
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (BuildContext context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Market App',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.kScaffoldColor,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: clint.auth.currentUser != null
              ? state is GetUserDataLoading
                    ? Scaffold(body: Center(child: CustomCircularIndicator()))
                    : MainHomeScreen(
                        userDataModel: AuthenticationCubit.get(
                          context,
                        ).userDataModel!,
                      )
              : const LoginScreen(),
        );
      },
    );
  }
}
