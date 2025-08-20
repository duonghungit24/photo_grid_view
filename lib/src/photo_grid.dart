import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_grid_view/src/photo_image_grid.dart';
import 'package:photo_grid_view/src/photo_list.dart';
import 'package:photo_grid_view/src/shared/enum.dart';

class PhotoGrid extends StatefulWidget {
  const PhotoGrid({
    super.key,
    required this.dataSource,
    this.displayType = PhotoGridViewType.list,
    this.height = 300,
    this.onTap,
  });

  final List<String> dataSource;
  final PhotoGridViewType displayType;
  final double height;
  final Function(int)? onTap;

  @override
  State<PhotoGrid> createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  List<String> dataSource = [];

  @override
  void initState() {
    dataSource = widget.dataSource;
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
        );
      case PhotoGridViewType.list:
        return PhotoList(listImage: widget.dataSource);
    }
  }
}
