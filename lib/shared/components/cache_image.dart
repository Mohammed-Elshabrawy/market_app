import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'custom_indicator.dart';


class CacheImage extends StatelessWidget {
  const CacheImage({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      height: 200,
      width: double.infinity,
      imageUrl: url,
      placeholder: (context, url) =>
          SizedBox(height: 200, child: CustomCircularIndicator()),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}