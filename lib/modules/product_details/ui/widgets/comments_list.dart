import 'package:flutter/material.dart';
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
        List<Map<String, dynamic>> data = asyncSnapshot.data!;
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (asyncSnapshot.hasData) {
          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => UserComment(),
            separatorBuilder: (context, index) => Divider(),
            itemCount: 10,
          );
        } else if (asyncSnapshot.hasError) {
          return Center(child: Text('Error: ${asyncSnapshot.error}'));
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}

class UserComment extends StatelessWidget {
  const UserComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "user Name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(children: [Text("comment 1")]),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              "Replay",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(children: [Text("Replay 1")]),
        SizedBox(height: 10),
      ],
    );
  }
}
