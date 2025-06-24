import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../models/product_model.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client
          .from('comments')
          .stream(primaryKey: ["id"])
          .eq('for_product', product.productId!)
          .order('created_at', ascending: false),
      builder: (context, asyncSnapshot) {
        SupabaseStreamEvent? data = asyncSnapshot.data;
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (asyncSnapshot.hasData) {
          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                UserComment(commentsData: data[index]),
            separatorBuilder: (context, index) => Divider(),
            itemCount: data!.length,
          );
        } else if (!asyncSnapshot.hasData) {
          return Center(child: Text('No Comments Yet'));
        } else {
          return Center(child: Text('Error: ${asyncSnapshot.error}'));
        }
      },
    );
  }
}

class UserComment extends StatelessWidget {
  UserComment({super.key, required this.commentsData});
  final Map<String, dynamic>? commentsData;

  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(commentsData!['created_at']);
    final dateFormat = DateFormat.yMEd().format(date);
    final timeFormat = DateFormat.Hm().format(date);

    return Column(
      children: [
        Row(
          children: [
            Text(
              commentsData!['user_name'] ?? "user Name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              " $dateFormat at $timeFormat",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(children: [Text(commentsData!['comment'] ?? "comment")]),
        SizedBox(height: 10),
        commentsData!['replay'] != null
            ? Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'replay:-',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(children: [commentsData!['replay']]),
                ],
              )
            : Container(),
        SizedBox(height: 10),
      ],
    );
  }
}
