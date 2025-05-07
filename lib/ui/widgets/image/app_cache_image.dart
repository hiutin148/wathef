import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wathef/core/styles/app_colors.dart';

class AppCacheImage extends StatelessWidget {
  const AppCacheImage({
    super.key,
    required this.imageUrl,
    this.fit,
    this.borderRadius,
    this.width,
    this.height,
    this.placeHolder,
  });

  final String imageUrl;
  final BoxFit? fit;
  final double? borderRadius;
  final double? width;
  final double? height;
  final Widget? placeHolder;

  @override
  Widget build(BuildContext context) {
    final defaultPlaceHolder = Container(
      width: width,
      height: height,
      color: AppColors.getRandomPlaceHolderColor(),
      child: Center(
        child: Icon(
          Icons.music_note,
          size: width != null ? width! / 4 : 24,
        ),
      ),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        errorWidget: (context, url, error) => placeHolder ?? defaultPlaceHolder,
        placeholder: (context, url) => placeHolder ?? defaultPlaceHolder,
        fit: fit ?? BoxFit.cover,
      ),
    );
  }
}
