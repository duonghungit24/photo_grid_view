import 'package:flutter/material.dart';
import 'package:photo_grid_view/photo_grid_view.dart';
import 'package:photo_grid_view/src/widgets/image_grid.dart';

class PhotoList extends StatefulWidget {
  const PhotoList(
      {super.key,
      required this.listImage,
      this.disableViewImage = false,
      required this.imgStyle});
  final List<String> listImage;
  final bool disableViewImage;
  final ImageGridStyle imgStyle;

  @override
  State<PhotoList> createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.listImage.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return ImageGrid(
                assetSource: widget.listImage[index],
                imgStyle: widget.imgStyle,
                onTap: () {
                  onViewImage(
                      context: context,
                      listImages: widget.listImage,
                      currentIndex: _currentIndex);
                },
              );
            },
            pageSnapping: true,
            physics: const ClampingScrollPhysics(),
          ),
          // Custom Indicator
          Positioned(
            bottom: 10,
            right: 10,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Text(
                  '${_currentIndex + 1}/${widget.listImage.length}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
