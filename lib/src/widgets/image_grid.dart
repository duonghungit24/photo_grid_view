import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_grid_view/src/shared/image_grid_style.dart';
import 'package:photo_grid_view/src/shared/utils.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid(
      {super.key,
      required this.assetSource,
      this.onTap,
      this.hero,
      required this.imgStyle});
  final String assetSource;
  final VoidCallback? onTap;
  final ImageGridStyle imgStyle;
  final Object? hero;

  @override
  Widget build(BuildContext context) {
    final isNetworkAsset = assetSource.isNetworkSource;
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(imgStyle.radius)),
        child: Hero(
          tag: hero ?? assetSource,
          child: isNetworkAsset
              ? CachedNetworkImage(
                  imageUrl: imgStyle.thumbnailSource ?? assetSource,
                  fit: imgStyle.boxFit,
                  placeholder: (context, url) => Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.white,
                      radius: 10,
                    ),
                  ),
                  width: imgStyle.imageWidth,
                  height: imgStyle.imageHeight,
                )
              : Image.asset(
                  assetSource,
                  fit: imgStyle.boxFit,
                  width: imgStyle.imageWidth,
                  height: imgStyle.imageHeight,
                ),
        ),
      ),
    );
  }
}
