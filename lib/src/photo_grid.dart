import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_grid_view/src/photo_image_grid.dart';
import 'package:photo_grid_view/src/photo_list.dart';
import 'package:photo_grid_view/src/shared/enum.dart';
import 'package:photo_grid_view/src/shared/image_grid_style.dart';

class PhotoGrid extends StatefulWidget {
  const PhotoGrid(
      {super.key,
      required this.dataSource,
      this.displayType = PhotoGridViewType.list,
      this.height = 300,
      this.onTap,
      this.imageStyle});

  final List<String> dataSource;
  final PhotoGridViewType displayType;
  final double height;
  final Function(int)? onTap;
  final ImageGridStyle? imageStyle;

  @override
  State<PhotoGrid> createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  List<String> dataSource = [];
  late ImageGridStyle imgStyle;
  @override
  void initState() {
    dataSource = widget.dataSource;
    imgStyle = widget.imageStyle ?? ImageGridStyle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.displayType) {
      case PhotoGridViewType.grid:
        return PhotoImageGrid(
          dataSource: dataSource,
          imgHeight: widget.height,
          onTapImage: widget.onTap,
          imgStyle: imgStyle,
        );
      case PhotoGridViewType.list:
        return PhotoList(
          listImage: widget.dataSource,
          imgStyle: imgStyle,
        );
    }
  }
}
