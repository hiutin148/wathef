import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCacheImage extends StatelessWidget {
  const AppCacheImage({
    super.key,
    required this.imageUrl,
    this.fit,
    this.borderRadius,
    this.width,
    this.height,
  });

  final String imageUrl;
  final BoxFit? fit;
  final double? borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: Colors.grey,
          child: Center(
            child: Icon(Icons.music_note, size: width != null ? width!/4 : 24,),
          ),
        ),
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: Colors.grey,
          child: Center(
            child: Icon(Icons.music_note, size: width != null ? width!/4 : 24,),
          ),
        ),
        fit: fit ?? BoxFit.cover,
      ),
    );
  }
}
