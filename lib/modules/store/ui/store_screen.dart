import 'package:flutter/material.dart';

import '../../../shared/components/custom_search_filed.dart';
import '../../../shared/components/product_list.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});
  static TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Center(
            child: Text(
              "Welcome to Market App",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ),
          SizedBox(height: 15),
          CustomSearchFiled(
            controller: searchController,
            label: 'Search in Market App',
            searchFunction: () {},
          ),
          SizedBox(height: 15),
          ProductList(),
        ],
      ),
    );
  }
}
