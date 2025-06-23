import 'package:flutter/material.dart';
import 'package:market_app/models/product_model.dart';

import '../../modules/product_details/ui/product_details_screen.dart';
import '../functions/navigateTo.dart';
import '../styles/style.dart';
import 'cache_image.dart';
import 'custom_btn.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, ProductDetailsScreen(product: product));
      },
      child: Card(
        color: AppColors.kWhiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: CacheImage(
                    url:
                        product.imageUrl ??
                        'https://imgs.search.brave.com/8PNka3Uob4IQ2a2AuN8GARnb4voItLxv_pRQcoevEwA/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZW5k/aGFtYmlrZXMuY29t/L2Nkbi9zaG9wL3By/b2R1Y3RzLzEyOTEw/VGhydXN0ZXJTYXR1/cm45UC5qcGc_dj0x/NjgzNTU3MjAzJndp/ZHRoPTk1MA',
                  ),
                ),
                Positioned(
                  child: Container(
                    width: 70,
                    height: 35,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${product.sale} % OFF",
                        style: TextStyle(
                          color: AppColors.kWhiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.productName ?? "Product Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            color: AppColors.kGreyColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              product.price ?? "Price",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              product.oldPrice ?? "Old Price",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.kGreyColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        CustomBtn(text: 'Buy Now'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
