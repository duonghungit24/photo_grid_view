import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_grid_view/src/shared/utils.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    super.key,
    required this.assetSource,
    this.thumbnailSource,
    this.imageHeight,
    this.imageWidth = double.infinity,
    this.onTap,
  });
  final String assetSource;
  final String? thumbnailSource;
  final BoxFit fit = BoxFit.cover;
  final double imageWidth;
  final double? imageHeight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isNetworkAsset = assetSource.isNetworkSource;
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Hero(
          tag: assetSource,
          child:
              isNetworkAsset
                  ? CachedNetworkImage(
                    imageUrl: thumbnailSource ?? assetSource,
                    fit: fit,
                    placeholder:
                        (context, url) => Center(
                          child: CupertinoActivityIndicator(
                            color: Colors.white,
                            radius: 10,
                          ),
                        ),
                    width: imageWidth,
                    height: imageHeight,
                  )
                  : Image.asset(
                    assetSource,
                    fit: fit,
                    width: imageWidth,
                    height: imageHeight,
                  ),
        ),
      ),
    );
  }
}
