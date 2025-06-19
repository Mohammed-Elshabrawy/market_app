import 'package:flutter/material.dart';
import '../../../shared/components/product_list.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Center(
            child: Text(
              "Your Favorite products",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ),
          SizedBox(height: 15),
          ProductList(),
        ],
      ),
    );
  }
}
