import 'package:flutter/material.dart';
import 'package:market_app/modules/home/ui/widgets/categorise_list_view.dart';
import '../../../shared/components/custom_search_filed.dart';
import '../../../shared/components/product_list.dart';

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
          SizedBox(height: 15),
          Image.asset("assets/images/buy.jpg"),
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
  }
}
