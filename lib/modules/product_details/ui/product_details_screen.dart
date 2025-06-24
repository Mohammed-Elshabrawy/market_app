import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:market_app/modules/product_details/ui/widgets/comments_list.dart';
import 'package:market_app/shared/functions/navigate_to_without_back.dart';
import 'package:market_app/shared/styles/style.dart';

import '../../../models/product_model.dart';
import '../../../shared/components/cache_image.dart';
import '../../../shared/components/custom_text_filed.dart';
import '../../../shared/functions/build_custom_app_bar.dart';
import '../logic/product_details_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;

  static TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ProductDetailsCubit()..getRates(productId: product.productId!),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (BuildContext context, ProductDetailsState state) {
          if (state is AddOrUpdateRateSuccess) {
            navigateToWithoutBack(context, screen: this);
          }
        },
        builder: (BuildContext context, ProductDetailsState state) {
          ProductDetailsCubit cubit = ProductDetailsCubit.get(context);
          return Scaffold(
            appBar: buildCustomAppBar(
              context,
              label: product.productName ?? 'Product Name',
            ),
            body: state is GetRatesLoading
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      CacheImage(
                        url:
                            product.imageUrl ??
                            'https://imgs.search.brave.com/8PNka3Uob4IQ2a2AuN8GARnb4voItLxv_pRQcoevEwA/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZW5k/aGFtYmlrZXMuY29t/L2Nkbi9zaG9wL3By/b2R1Y3RzLzEyOTEw/VGhydXN0ZXJTYXR1/cm45UC5qcGc_dj0x/NjgzNTU3MjAzJndp/ZHRoPTk1MA',
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(product.productName ?? "product name"),
                                Text('${product.price} LE'),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("${cubit.averageRate}  "),
                                    Icon(Icons.star, color: Colors.amber),
                                  ],
                                ),
                                Icon(
                                  Icons.favorite,
                                  color: AppColors.kGreyColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Text(product.description ?? "Product Description"),
                            SizedBox(height: 20),
                            RatingBar.builder(
                              initialRating: cubit.userRate.toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              itemBuilder: (context, _) =>
                                  Icon(Icons.star, color: Colors.amber),
                              onRatingUpdate: (rating) {
                                cubit.addOrUpdateRate(
                                  productId: product.productId!,
                                  data: {
                                    "rate": rating.toInt(),
                                    "for_user": cubit.userId(),
                                    "for_product": product.productId,
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            CustomTextFormFiled(
                              suffix: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.send,
                                  color: AppColors.kPrimaryColor,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: AppColors.kBorderSideColor,
                                  width: 2,
                                ),
                              ),
                              controller: commentController,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'please enter your comment';
                                }
                                return null;
                              },
                              label: 'Type Your Feedback',
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Text(
                                  "Comments",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            CommentsList(),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
