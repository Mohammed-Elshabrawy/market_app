import 'package:flutter/material.dart';

import '../../../shared/components/product_list.dart';
import '../../../shared/functions/build_custom_app_bar.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, label: category),
      body: ListView(
        children: [
          SizedBox(height: 10),
          ProductList(category: category),
        ],
      ),
    );
  }
}
