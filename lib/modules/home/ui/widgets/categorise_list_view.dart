import 'package:flutter/material.dart';

import '../../../../shared/styles/style.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.0,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.kPrimaryColor,
                foregroundColor: AppColors.kWhiteColor,
                child: Icon(categories[index].icon, size: 40),
              ),
              SizedBox(height: 10),
              Text(
                categories[index].title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        itemCount: categories.length,
      ),
    );
  }
}


List<Category> categories = [
  Category(icon: Icons.sports, title: "Sports"),
  Category(icon: Icons.tv, title: "Electronics"),
  Category(icon: Icons.collections, title: "Collections"),
  Category(icon: Icons.book, title: "Books"),
  Category(icon: Icons.games_outlined, title: "Games"),
  Category(icon: Icons.watch, title: "Watches"),
];

class Category {
  const Category({required this.icon, required this.title});
  final IconData icon;
  final String title;
}