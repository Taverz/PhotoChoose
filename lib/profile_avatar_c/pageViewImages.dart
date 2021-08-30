


// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/material.dart';

// Widget getPagesView(){
//   return ExtendedImageGesturePageView.builder(
//   itemBuilder: (BuildContext context, int index) {
//     var item = widget.pics[index].picUrl;
//     Widget image = ExtendedImage.network(
//       item,
//       fit: BoxFit.contain,
//       mode: ExtendedImageMode.gesture,
//       gestureConfig: GestureConfig(
//         inPageView: true, initialScale: 1.0,
//         //you can cache gesture state even though page view page change.
//         //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
//         cacheGesture: false
//       ),
//     );
//     image = Container(
//       child: image,
//       padding: EdgeInsets.all(5.0),
//     );
//     if (index == currentIndex) {
//       return Hero(
//         tag: item + index.toString(),
//         child: image,
//       );
//     } else {
//       return image;
//     }
//   },
//   itemCount: widget.pics.length,
//   onPageChanged: (int index) {
//     currentIndex = index;
//     rebuild.add(index);
//   },
//   controller: PageController(
//     initialPage: currentIndex,
//   ),
//   scrollDirection: Axis.horizontal,
// ),
// }