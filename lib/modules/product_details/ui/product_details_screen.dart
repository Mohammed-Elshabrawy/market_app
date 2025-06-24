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
import '../../auth/logic/authentication_cubit.dart';
import '../logic/product_details_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final TextEditingController commentController = TextEditingController();
  GlobalKey<FormState> commentFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ProductDetailsCubit()..getRates(productId: widget.product.productId!),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (BuildContext context, ProductDetailsState state) {
          if (state is AddOrUpdateRateSuccess) {
            navigateToWithoutBack(context, screen: widget);
          }
        },
        builder: (BuildContext context, ProductDetailsState state) {
          ProductDetailsCubit cubit = ProductDetailsCubit.get(context);
          return Scaffold(
            appBar: buildCustomAppBar(
              context,
              label: widget.product.productName ?? 'Product Name',
            ),
            body: state is GetRatesLoading || state is AddCommentLoading
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      CacheImage(
                        url:
                            widget.product.imageUrl ??
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
                                Text(
                                  widget.product.productName ?? "product name",
                                ),
                                Text('${widget.product.price} LE'),
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
                            Text(
                              widget.product.description ??
                                  "Product Description",
                            ),
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
                                  productId: widget.product.productId!,
                                  data: {
                                    "rate": rating.toInt(),
                                    "for_user": cubit.userId(),
                                    "for_product": widget.product.productId,
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            Form(
                              key: commentFormKey,
                              child: CustomTextFormFiled(
                                suffix: IconButton(
                                  onPressed: () async {
                                    if (commentFormKey.currentState!
                                        .validate()) {
                                      await cubit.addComment(
                                        data: {
                                          "comment": commentController.text
                                              .trim(),
                                          "for_user": cubit.userId(),
                                          "for_product":
                                              widget.product.productId,
                                          "user_name": context
                                              .read<AuthenticationCubit>()
                                              .userDataModel!
                                              .name,
                                        },
                                      );
                                      commentController.clear();
                                    }
                                  },
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
                                  } else if (value.length < 10) {
                                    return 'comment must be at least 10 characters';
                                  }
                                  return null;
                                },
                                label: 'Type Your Feedback',
                              ),
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
