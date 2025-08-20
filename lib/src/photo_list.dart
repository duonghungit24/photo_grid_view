import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_grid_view/src/photo_view.dart';
import 'package:photo_grid_view/src/widgets/shimmer_shape.dart';
import 'package:dismissible_page/dismissible_page.dart';

class PhotoList extends StatefulWidget {
  const PhotoList({
    super.key,
    required this.listImage,
    this.disableViewImage = false,
  });
  final List<String> listImage;
  final bool disableViewImage;

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
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  context.pushTransparentRoute(
                    PhotoView(
                      images: widget.listImage,
                      intialIndex: _currentIndex,
                    ),
                  );
                },
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  imageUrl: widget.listImage[index],
                  placeholder:
                      (context, url) => ShimmerShape.rectangular(
                        width: double.infinity,
                        height: 160,
                      ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
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

  List<Widget> _buildIndicators() {
    const int maxIndicators = 4; // Số indicator tối đa hiển thị (giống Threads)
    int startIndex = (_currentIndex ~/ maxIndicators) * maxIndicators;
    int endIndex = (startIndex + maxIndicators).clamp(
      0,
      widget.listImage.length,
    );

    return List.generate(endIndex - startIndex, (index) {
      int displayIndex = startIndex + index;
      bool isActive = _currentIndex == displayIndex;
      return AnimatedContainer(
        duration: const Duration(
          milliseconds: 300,
        ), // Tốc độ chuyển đổi mượt mà
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: 8.0,
        width: isActive ? 12.0 : 8.0, // Chấm hiện tại lớn hơn một chút
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.white.withOpacity(0.5),
          shape: BoxShape.circle, // Dùng hình tròn giống Threads
        ),
      );
    });
  }
}
