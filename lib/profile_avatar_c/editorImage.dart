

// import 'dart:typed_data';

// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/widgets.dart';



// Widget editorImage(Path path){
//     return ExtendedImage.asset(
//           path.toString(), //'assets/image.jpg',
//         fit: BoxFit.contain,
//         mode: ExtendedImageMode.editor,
//         enableLoadState: true,
//         extendedImageEditorKey: editorKey,
//         cacheRawData: true,
//         initEditorConfigHandler: (ExtendedImageState? state) {
//           return EditorConfig(
//               maxScale: 8.0,
//               cropRectPadding: const EdgeInsets.all(20.0),
//               hitTestSize: 20.0,
//               initCropRectType: InitCropRectType.imageRect,
//               cropAspectRatio: CropAspectRatios.ratio4_3,
//               editActionDetailsIsChanged: (EditActionDetails? details) {
//                 print(details?.totalScale);
//               });
//         },
//     );
//   }
  
//     final GlobalKey<ExtendedImageEditorState> editorKey =
//       GlobalKey<ExtendedImageEditorState>();
//   bool _cropping = false;

//   Future<void> cropImage() async {
//     if (_cropping) {
//       return;
//     }
//     final Uint8List fileData = Uint8List.fromList(kIsWeb
//         ? (await cropImageDataWithDartLibrary(state: editorKey.currentState!))!
//         : (await cropImageDataWithNativeLibrary(
//             state: editorKey.currentState!))!);
//     final String? fileFath =
//         await ImageSaver.save('extended_image_cropped_image.jpg', fileData);

//     // showToast('save image : $fileFath');
//     _cropping = true;
//   }
