import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_grid_view/photo_grid_view.dart';

extension ImageSourcePath on String {
  bool get isNetworkSource => startsWith('http://') || startsWith('https://');
}

void onViewImage(
    {required BuildContext context,
    required List<String> listImages,
    required int currentIndex,
    Object? hero}) {
  context.pushTransparentRoute(
    PhotoView(images: listImages, intialIndex: currentIndex, hero: hero),
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 250),
  );
}
