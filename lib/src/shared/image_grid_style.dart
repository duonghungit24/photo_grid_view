import 'package:flutter/material.dart';

class ImageGridStyle {
  /// Height of each image, default is 300.
  final double imageWidth;

  /// Width of each image default on WidthScreen.
  final double imageHeight;

  // image default
  final String? thumbnailSource;

  final BoxFit boxFit;

  final double radius;

  ImageGridStyle(
      {this.imageWidth = double.infinity,
      this.imageHeight = 300.0,
      this.thumbnailSource,
      this.boxFit = BoxFit.cover,
      this.radius = 8});
}
