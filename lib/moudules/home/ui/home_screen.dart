import 'package:flutter/material.dart';

import '../../../shared/components/custom_search_filed.dart';
import 'Widets/categorise_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          CustomSearchFiled(
            label: 'Search in Market App',
            searchFunction: () {},
          ),
          SizedBox(height: 20),
          Image.asset("assets/images/buy.jpg"),
          SizedBox(height: 20),
          Text(
            "Popular Categories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 2,
            ),
          ),
          SizedBox(height: 20),
          CategoriesList(),
        ],
      ),
    );
  }
}
