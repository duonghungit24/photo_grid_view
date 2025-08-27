import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_grid_view/photo_grid_view.dart';
import 'package:photo_grid_view/src/widgets/rounded_icon_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:dismissible_page/dismissible_page.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({super.key, this.images = const [], this.intialIndex = 0});

  final List<String> images;
  final int intialIndex;
  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  late PageController pageController;
  late int currentPage;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.intialIndex);
    currentPage = widget.intialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      direction: DismissiblePageDismissDirection.vertical,
      isFullScreen: true,
      disabled: false,
      minRadius: 10,
      maxRadius: 10,
      dragSensitivity: 1.0,
      maxTransformValue: .8,
      dismissThresholds: {
        DismissiblePageDismissDirection.vertical: .2,
      },
      minScale: .8,
      startingOpacity: 1,
      reverseDuration: const Duration(milliseconds: 250),
      child: Stack(
        children: [
          Positioned.fill(
            child: PhotoViewGallery.builder(
              pageController: pageController,
              itemCount: widget.images.length,
              builder: (context, index) {
                final assetSource = widget.images[index];
                return PhotoViewGalleryPageOptions.customChild(
                  child: ImageGrid(
                      assetSource: assetSource,
                      imgStyle: ImageGridStyle(
                        boxFit: BoxFit.contain,
                      )),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 3,
                );
              },
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration: BoxDecoration(color: Colors.transparent),
              loadingBuilder: (context, event) => const Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  // child: CircularProgressIndicator(
                  //   value: event == null ? 0 : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
                  // ),
                  child: CupertinoActivityIndicator(
                    color: Colors.white,
                    radius: 10,
                  ),
                ),
              ),
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
            ),
          ),

          // Close button (safe area)
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Center(
                  child: Icon(Icons.close, color: Colors.white, size: 22),
                ),
              ),
            ),
          ),

          // Position indicator (safe area)
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  '${currentPage + 1}/${widget.images.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),

          // Navigation arrows
          if (widget.images.length > 1)
            Positioned(
              left: 10,
              top: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Material(
                  color:
                      Colors.transparent, // Đảm bảo Material không che khu vực
                  child: RoundedIconButton(
                    width: 48,
                    height: 48,
                    onTap: () {
                      if (currentPage > 0) {
                        pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    backgroundColor: Colors.black.withValues(alpha: 0.3),
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          if (widget.images.length > 1)
            Positioned(
              right: 10,
              top: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.centerRight,
                child: Material(
                  color:
                      Colors.transparent, // Đảm bảo Material không che khu vực
                  child: RoundedIconButton(
                    width: 48,
                    height: 48,
                    onTap: () {
                      if (currentPage < widget.images.length - 1) {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    backgroundColor: Colors.black.withValues(alpha: 0.3),
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 25,
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
