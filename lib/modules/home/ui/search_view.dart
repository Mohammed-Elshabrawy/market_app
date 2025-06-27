import 'package:flutter/material.dart';

import '../../../shared/components/product_list.dart';
import '../../../shared/functions/build_custom_app_bar.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, label: 'Search Results'),
      body: ListView(children: [SizedBox(height: 10), ProductList()]),
    );
  }
}
