import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/modules/home/ui/search_view.dart';
import 'package:market_app/modules/home/ui/widgets/categorise_list_view.dart';

import '../../../shared/components/custom_search_filed.dart';
import '../../../shared/components/product_list.dart';
import '../../../shared/functions/navigateTo.dart';
import '../../auth/logic/authentication_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

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
              Row(
                children: [
                  Text(
                    "Welcome Back, ${AuthenticationCubit.get(context).userDataModel!.name.split(" ")[0]}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                ],
              ),
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
