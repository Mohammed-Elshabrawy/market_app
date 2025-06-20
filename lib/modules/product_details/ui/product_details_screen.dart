import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:market_app/modules/product_details/ui/widgets/comments_list.dart';
import 'package:market_app/shared/styles/style.dart';

import '../../../shared/components/cache_image.dart';
import '../../../shared/components/custom_text_filed.dart';
import '../../../shared/functions/build_custom_app_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  static TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, label: 'Product Name'),
      body: ListView(
        children: [
          CacheImage(
            url:
                'https://imgs.search.brave.com/8PNka3Uob4IQ2a2AuN8GARnb4voItLxv_pRQcoevEwA/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZW5k/aGFtYmlrZXMuY29t/L2Nkbi9zaG9wL3By/b2R1Y3RzLzEyOTEw/VGhydXN0ZXJTYXR1/cm45UC5qcGc_dj0x/NjgzNTU3MjAzJndp/ZHRoPTk1MA',
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("product name"), Text("4500 LE")],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("3  "),
                        Icon(Icons.star, color: Colors.amber),
                      ],
                    ),
                    Icon(Icons.favorite, color: AppColors.kGreyColor),
                  ],
                ),
                SizedBox(height: 30),
                Text("Product Description"),
                SizedBox(height: 20),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                      Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 20),
                CustomTextFormFiled(
                  suffix: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send, color: AppColors.kPrimaryColor),
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
  }
}
