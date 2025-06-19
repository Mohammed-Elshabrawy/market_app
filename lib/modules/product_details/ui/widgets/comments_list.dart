import 'package:flutter/material.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => UserComment(),
      separatorBuilder: (context, index) => Divider(),
      itemCount: 10,
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
