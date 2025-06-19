import 'package:flutter/material.dart';
import 'package:market_app/shared/components/product_card.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key, this.shrinkWrap, this.physics});
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap ?? true,
      physics: physics ?? NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ProductCard(),
      ),
    );
  }
}
