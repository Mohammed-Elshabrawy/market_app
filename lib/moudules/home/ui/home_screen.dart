import 'package:flutter/material.dart';

import '../../../shared/components/custom_search_filed.dart';

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
        ],
      ),
    );
  }
}
