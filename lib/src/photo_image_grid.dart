import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:photo_grid_view/src/shared/image_grid_style.dart';
import 'package:photo_grid_view/src/shared/utils.dart';
import 'package:photo_grid_view/src/widgets/image_grid.dart';

class PhotoImageGrid extends StatelessWidget {
  const PhotoImageGrid(
      {super.key,
      required this.dataSource,
      this.imgHeight,
      this.onTapImage,
      required this.imgStyle});

  final List<String> dataSource;

  final double? imgHeight;

  final Function(int)? onTapImage;

  final ImageGridStyle imgStyle;

  @override
  Widget build(BuildContext context) {
    final assetCount = dataSource.length;

    void onTap(index) {
      if (onTapImage != null) {
        onTapImage?.call(index);
      } else {
        onViewImage(
            context: context,
            listImages: dataSource,
            currentIndex: dataSource.indexOf(dataSource[index]));
      }
    }

    return SizedBox(
      height: imgHeight ?? 300.0,
      child: switch (assetCount) {
        1 => ImageGrid(
            assetSource: dataSource[0],
            onTap: () => onTap(0),
            imgStyle: imgStyle,
          ),
        2 => Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ImageGrid(
                        assetSource: dataSource[0],
                        onTap: () => onTap(0),
                        imgStyle: imgStyle,
                      ),
                    ),
                    const Gap(6.0),
                    Expanded(
                      child: ImageGrid(
                        assetSource: dataSource[1],
                        onTap: () => onTap(1),
                        imgStyle: imgStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        3 => Row(
            children: [
              Expanded(
                child: ImageGrid(
                  assetSource: dataSource[0],
                  onTap: () => onTap(0),
                  imgStyle: imgStyle,
                ),
              ),
              const Gap(6.0),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ImageGrid(
                        assetSource: dataSource[1],
                        onTap: () => onTap(1),
                        imgStyle: imgStyle,
                      ),
                    ),
                    const Gap(6.0),
                    Expanded(
                      child: ImageGrid(
                        assetSource: dataSource[2],
                        onTap: () => onTap(2),
                        imgStyle: imgStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        4 => Row(
            children: [
              Expanded(
                child: ImageGrid(
                  assetSource: dataSource[0],
                  onTap: () => onTap(0),
                  imgStyle: imgStyle,
                ),
              ),
              const Gap(6.0),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ImageGrid(
                        assetSource: dataSource[1],
                        onTap: () => onTap(1),
                        imgStyle: imgStyle,
                      ),
                    ),
                    const Gap(6.0),
                    Expanded(
                      child: ImageGrid(
                        assetSource: dataSource[2],
                        onTap: () => onTap(2),
                        imgStyle: imgStyle,
                      ),
                    ),
                    const Gap(6.0),
                    Expanded(
                      child: ImageGrid(
                        assetSource: dataSource[3],
                        onTap: () => onTap(3),
                        imgStyle: imgStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        >= 5 => Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ImageGrid(
                        assetSource: dataSource[0],
                        onTap: () => onTap(0),
                        imgStyle: imgStyle,
                      ),
                    ),
                    const Gap(6.0),
                    Expanded(
                      child: ImageGrid(
                        assetSource: dataSource[1],
                        onTap: () => onTap(1),
                        imgStyle: imgStyle,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(6.0),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ImageGrid(
                        assetSource: dataSource[2],
                        onTap: () => onTap(2),
                        imgStyle: imgStyle,
                      ),
                    ),
                    const Gap(6.0),
                    Expanded(
                      child: ImageGrid(
                        assetSource: dataSource[3],
                        onTap: () => onTap(3),
                        imgStyle: imgStyle,
                      ),
                    ),
                    const Gap(6.0),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: ImageGrid(
                              assetSource: dataSource[4],
                              onTap: () => onTap(4),
                              imgStyle: imgStyle,
                            ),
                          ),
                          if (assetCount > 5) ...moreAssetCover(assetCount - 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        _ => Container(),
      },
    );
  }

  List<Widget> moreAssetCover(int numberOfAsset) {
    return [
      IgnorePointer(
        ignoring: true,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: Container(
            color: Colors.black.withAlpha((0.5 * 255.0).toInt()),
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: IgnorePointer(
          ignoring: true,
          child: Text(
            '+$numberOfAsset',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    ];
  }
}
