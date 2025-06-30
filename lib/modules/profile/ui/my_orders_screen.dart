import 'package:flutter/material.dart';
import 'package:market_app/shared/components/product_list.dart';

import '../../../shared/functions/build_custom_app_bar.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, label: 'My Orders'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProductList(
          shrinkWrap: false,
          physics: BouncingScrollPhysics(),
          isMyOrdersScreen: true,
        ),
      ),
    );
  }
}
