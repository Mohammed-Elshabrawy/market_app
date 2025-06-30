import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/modules/home/ui/search_view.dart';
import 'package:market_app/modules/home/ui/widgets/categorise_list_view.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

import '../../../shared/components/custom_search_filed.dart';
import '../../../shared/components/product_list.dart';
import '../../../shared/functions/navigateTo.dart';
import '../../../shared/network/remote/paymob.dart';
import '../../../shared/styles/style.dart';
import '../../auth/logic/authentication_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    PaymentData.initialize(
      apiKey:
          paymobApi, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
      iframeId: paymobIFrame, // Required: Found under Developers -> iframes
      integrationCardId:
          paymobIntegrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
      integrationMobileWalletId:
          paymobIntegrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID
      // Optional User Data
      userData: UserData(
        email: "User Email", // Optional: Defaults to 'NA'
        phone: "User Phone", // Optional: Defaults to 'NA'
        name: "User First Name", // Optional: Defaults to 'NA'
        lastName: "User Last Name", // Optional: Defaults to 'NA'
      ),

      // Optional Style Customizations
      style: Style(
        primaryColor: AppColors.kPrimaryColor, // Default: Colors.blue
        scaffoldColor: AppColors.kWhiteColor, // Default: Colors.white
        appBarBackgroundColor: AppColors.kPrimaryColor, // Default: Colors.blue
        textStyle: TextStyle(), // Default: TextStyle()
        buttonStyle: ElevatedButton.styleFrom(
          foregroundColor: AppColors.kWhiteColor,
          backgroundColor: AppColors.kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ), // Default: ElevatedButton.styleFrom()
        circleProgressColor: AppColors.kPrimaryColor, // Default: Colors.blue
        unselectedColor: AppColors.kGreyColor, // Default: Colors.grey
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {},
      builder: (BuildContext context, AuthenticationState state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(height: 15),
              /* Row(
                children: [
                  Text(
                    "Welcome Back, ${AuthenticationCubit.get(context).userDataModel!.name.split(" ")[0]}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                ],
              ),*/
              SizedBox(height: 15),
              CustomSearchFiled(
                controller: _searchController,
                label: 'Search in Market App',
                searchFunction: () {
                  if (_searchController.text.isNotEmpty) {
                    navigateTo(
                      context,
                      SearchView(searchText: _searchController.text),
                    );
                    _searchController.clear();
                  }
                },
              ),
              SizedBox(height: 15),
              Image.asset("assets/images/buy.jpg", fit: BoxFit.cover),
              SizedBox(height: 15),
              Text(
                "Popular Categories",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              SizedBox(height: 15),
              CategoriesList(),
              SizedBox(height: 15),
              Text(
                "Recently Added",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              SizedBox(height: 15),
              ProductList(),
            ],
          ),
        );
      },
    );
  }
}
