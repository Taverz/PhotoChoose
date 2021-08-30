import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

// import 'package:example/common/image_picker/image_picker.dart';
// import 'package:example/common/utils/crop_editor_helper.dart';
// import 'package:example/common/widget/common_widget.dart';
import 'package:extended_image/extended_image.dart';
// import 'package:ff_annotation_route_core/ff_annotation_route_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:oktoast/oktoast.dart';
// import 'package:url_launcher/url_launcher.dart';



import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

//import 'package:image_picker/image_picker.dart' as picker;
import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';






//import 'dart:typed_data';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/foundation.dart';

// ignore: implementation_imports
import 'package:http/src/response.dart';
import 'package:http_client_helper/http_client_helper.dart';

// import 'package:isolate/load_balancer.dart';
// import 'package:isolate/isolate_runner.dart';
import 'package:extended_image/extended_image.dart';
// import 'package:image/image.dart';
// import 'package:image_editor/image_editor.dart';



class ImageEditorDemo extends StatefulWidget {
  Uint8List image;
  ImageEditorDemo(this.image);

  @override
  _ImageEditorDemoState createState() => _ImageEditorDemoState();
}

class _ImageEditorDemoState extends State<ImageEditorDemo> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  final GlobalKey<PopupMenuButtonState<EditorCropLayerPainter>> popupMenuKey =
      GlobalKey<PopupMenuButtonState<EditorCropLayerPainter>>();
  final List<AspectRatioItem> _aspectRatios = <AspectRatioItem>[
    AspectRatioItem(text: 'custom', value: CropAspectRatios.custom),
    AspectRatioItem(text: 'original', value: CropAspectRatios.original),
    AspectRatioItem(text: '1*1', value: CropAspectRatios.ratio1_1),
    AspectRatioItem(text: '4*3', value: CropAspectRatios.ratio4_3),
    AspectRatioItem(text: '3*4', value: CropAspectRatios.ratio3_4),
    AspectRatioItem(text: '16*9', value: CropAspectRatios.ratio16_9),
    AspectRatioItem(text: '9*16', value: CropAspectRatios.ratio9_16)
  ];
  AspectRatioItem? _aspectRatio;
  bool _cropping = false;

  EditorCropLayerPainter? _cropLayerPainter;

  @override
  void initState() {
    _aspectRatio = _aspectRatios.first;
    _cropLayerPainter = const EditorCropLayerPainter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('image editor'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: _getImage,
          ),
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              if (kIsWeb) {
                _cropImage(false);
              } else {
                _showCropDialog(context);
              }
            },
          ),
        ],
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: _memoryImage != null
              ? ExtendedImage.memory(
                  _memoryImage!,
                  fit: BoxFit.contain,
                  mode: ExtendedImageMode.editor,
                  enableLoadState: true,
                  extendedImageEditorKey: editorKey,
                  initEditorConfigHandler: (ExtendedImageState? state) {
                    return EditorConfig(
                      maxScale: 8.0,
                      cropRectPadding: const EdgeInsets.all(20.0),
                      hitTestSize: 20.0,
                      cropLayerPainter: _cropLayerPainter!,
                      initCropRectType: InitCropRectType.imageRect,
                      cropAspectRatio: _aspectRatio!.value,
                    );
                  },
                  cacheRawData: true,
                )
              : ExtendedImage.asset(
                  'assets/image.jpg',
                  fit: BoxFit.contain,
                  mode: ExtendedImageMode.editor,
                  enableLoadState: true,
                  extendedImageEditorKey: editorKey,
                  initEditorConfigHandler: (ExtendedImageState? state) {
                    return EditorConfig(
                      maxScale: 8.0,
                      cropRectPadding: const EdgeInsets.all(20.0),
                      hitTestSize: 20.0,
                      cropLayerPainter: _cropLayerPainter!,
                      initCropRectType: InitCropRectType.imageRect,
                      cropAspectRatio: _aspectRatio!.value,
                    );
                  },
                  cacheRawData: true,
                ),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        //color: Colors.lightBlue,
        shape: const CircularNotchedRectangle(),
        child: ButtonTheme(
          minWidth: 0.0,
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FlatButtonWithIcon(
                icon: const Icon(Icons.crop),
                label: const Text(
                  'Crop',
                  style: TextStyle(fontSize: 10.0),
                ),
                textColor: Colors.white,
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          children: <Widget>[
                            const Expanded(
                              child: SizedBox(),
                            ),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(20.0),
                                itemBuilder: (_, int index) {
                                  final AspectRatioItem item =
                                      _aspectRatios[index];
                                  return GestureDetector(
                                    child: AspectRatioWidget(
                                      aspectRatio: item.value,
                                      aspectRatioS: item.text,
                                      isSelected: item == _aspectRatio,
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        _aspectRatio = item;
                                      });
                                    },
                                  );
                                },
                                itemCount: _aspectRatios.length,
                              ),
                            ),
                          ],
                        );
                      });
                },
              ),
              FlatButtonWithIcon(
                icon: const Icon(Icons.flip),
                label: const Text(
                  'Flip',
                  style: TextStyle(fontSize: 10.0),
                ),
                textColor: Colors.white,
                onPressed: () {
                  editorKey.currentState!.flip();
                },
              ),
              FlatButtonWithIcon(
                icon: const Icon(Icons.rotate_left),
                label: const Text(
                  'Rotate Left',
                  style: TextStyle(fontSize: 8.0),
                ),
                textColor: Colors.white,
                onPressed: () {
                  editorKey.currentState!.rotate(right: false);
                },
              ),
              FlatButtonWithIcon(
                icon: const Icon(Icons.rotate_right),
                label: const Text(
                  'Rotate Right',
                  style: TextStyle(fontSize: 8.0),
                ),
                textColor: Colors.white,
                onPressed: () {
                  editorKey.currentState!.rotate(right: true);
                },
              ),
              FlatButtonWithIcon(
                icon: const Icon(Icons.rounded_corner_sharp),
                label: PopupMenuButton<EditorCropLayerPainter>(
                  key: popupMenuKey,
                  enabled: false,
                  offset: const Offset(100, -300),
                  child: const Text(
                    'Painter',
                    style: TextStyle(fontSize: 8.0),
                  ),
                  initialValue: _cropLayerPainter,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<EditorCropLayerPainter>>[
                      PopupMenuItem<EditorCropLayerPainter>(
                        child: Row(
                          children: const <Widget>[
                            Icon(
                              Icons.rounded_corner_sharp,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Default'),
                          ],
                        ),
                        value: const EditorCropLayerPainter(),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem<EditorCropLayerPainter>(
                        child: Row(
                          children: const <Widget>[
                            Icon(
                              Icons.circle,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Custom'),
                          ],
                        ),
                        value: const CustomEditorCropLayerPainter(),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem<EditorCropLayerPainter>(
                        child: Row(
                          children: const <Widget>[
                            Icon(
                              CupertinoIcons.circle,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Circle'),
                          ],
                        ),
                        value: const CircleEditorCropLayerPainter(),
                      ),
                    ];
                  },
                  onSelected: (EditorCropLayerPainter value) {
                    if (_cropLayerPainter != value) {
                      setState(() {
                        if (value is CircleEditorCropLayerPainter) {
                          _aspectRatio = _aspectRatios[2];
                        }
                        _cropLayerPainter = value;
                      });
                    }
                  },
                ),
                textColor: Colors.white,
                onPressed: () {
                  popupMenuKey.currentState!.showButtonMenu();
                },
              ),
              FlatButtonWithIcon(
                icon: const Icon(Icons.restore),
                label: const Text(
                  'Reset',
                  style: TextStyle(fontSize: 10.0),
                ),
                textColor: Colors.white,
                onPressed: () {
                  editorKey.currentState!.reset();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCropDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        builder: (BuildContext content) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Material(
                      child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'select library to crop',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text.rich(TextSpan(children: <TextSpan>[
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Image',
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                      decorationColor: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // launch(
                                      //     'https://github.com/brendan-duncan/image');
                                    }),
                              const TextSpan(
                                  text:
                                      '(Dart library) for decoding/encoding image formats, and image processing. It\'s stable.')
                            ],
                          ),
                          const TextSpan(text: '\n\n'),
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'ImageEditor',
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                      decorationColor: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // launch(
                                      //     'https://github.com/fluttercandies/flutter_image_editor');
                                    }
                                    ),
                              const TextSpan(
                                  text:
                                      '(Native library) support android/ios, crop flip rotate. It\'s faster.')
                            ],
                          )
                        ])),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            OutlinedButton(
                              child: const Text(
                                'Dart',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                _cropImage(false);
                              },
                            ),
                            OutlinedButton(
                              child: const Text(
                                'Native',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                _cropImage(true);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ))),
              Expanded(
                child: Container(),
              )
            ],
          );
        });
  }

  Future<void> _cropImage(bool useNative) async {
    if (_cropping) {
      return;
    }
    String msg = '';
    try {
      _cropping = true;

      //await showBusyingDialog();

      Uint8List? fileData;

      /// native library
      // if (useNative) {
        fileData = await cropImageDataWithNativeLibrary(
            state: editorKey.currentState!);
      // } 
      // else {
      //   ///delay due to cropImageDataWithDartLibrary is time consuming on main thread
      //   ///it will block showBusyingDialog
      //   ///if you don't want to block ui, use compute/isolate,but it costs more time.
      //   //await Future.delayed(Duration(milliseconds: 200));

      //   ///if you don't want to block ui, use compute/isolate,but it costs more time.
      //   fileData =
      //       await cropImageDataWithDartLibrary(state: editorKey.currentState!);
      // }
      final String? filePath =
          await ImageSaver.save('extended_image_cropped_image.jpg', fileData!);
      // var filePath = await ImagePickerSaver.saveFile(fileData: fileData);

      msg = 'save image : $filePath';
    } catch (e, stack) {
      msg = 'save failed: $e\n $stack';
      print(msg);
    }

    //Navigator.of(context).pop();
    // showToast(msg);
    _cropping = false;
  }

  Uint8List? _memoryImage;
  Future<void> _getImage() async {
    _memoryImage = await pickImage(context);
    //when back to current page, may be editorKey.currentState is not ready.
    Future<void>.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        editorKey.currentState!.reset();
      });
    });
  }
}

class CustomEditorCropLayerPainter extends EditorCropLayerPainter {
  const CustomEditorCropLayerPainter();
  @override
  void paintCorners(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Paint paint = Paint()
      ..color = painter.cornerColor
      ..style = PaintingStyle.fill;
    final Rect cropRect = painter.cropRect;
    const double radius = 6;
    canvas.drawCircle(Offset(cropRect.left, cropRect.top), radius, paint);
    canvas.drawCircle(Offset(cropRect.right, cropRect.top), radius, paint);
    canvas.drawCircle(Offset(cropRect.left, cropRect.bottom), radius, paint);
    canvas.drawCircle(Offset(cropRect.right, cropRect.bottom), radius, paint);
  }
}

class CircleEditorCropLayerPainter extends EditorCropLayerPainter {
  const CircleEditorCropLayerPainter();

  @override
  void paintCorners(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    // do nothing
  }

  @override
  void paintMask(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Rect rect = Offset.zero & size;
    final Rect cropRect = painter.cropRect;
    final Color maskColor = painter.maskColor;
    canvas.saveLayer(rect, Paint());
    canvas.drawRect(
        rect,
        Paint()
          ..style = PaintingStyle.fill
          ..color = maskColor);
    canvas.drawCircle(cropRect.center, cropRect.width / 2.0,
        Paint()..blendMode = BlendMode.clear);
    canvas.restore();
  }

  @override
  void paintLines(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Rect cropRect = painter.cropRect;
    if (painter.pointerDown) {
      canvas.save();
      canvas.clipPath(Path()..addOval(cropRect));
      super.paintLines(canvas, size, painter);
      canvas.restore();
    }
  }
}















Future<Uint8List?> pickImage(BuildContext context) async {
  List<AssetEntity> assets = <AssetEntity>[];
  final List<AssetEntity>? result = await AssetPicker.pickAssets(
    context,
    maxAssets: 1,
    pathThumbSize: 84,
    gridCount: 3,
    pageSize: 300,
    selectedAssets: assets,
    requestType: RequestType.image,
    // textDelegate: EnglishTextDelegate(),
  );
  if (result != null) {
    assets = List<AssetEntity>.from(result);
    return assets.first.originBytes;
  }
  return null;
  // final File file =

  //     await picker.ImagePicker.pickImage(source: picker.ImageSource.gallery);
  // return file.readAsBytes();
}

class ImageSaver {
  static Future<String?> save(String name, Uint8List fileData) async {
    final AssetEntity? imageEntity =
        await PhotoManager.editor.saveImage(fileData);
    final File? file = await imageEntity?.file;
    return file?.path;
  }
}











// //import 'dart:typed_data';
// import 'dart:isolate';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'package:flutter/foundation.dart';

// // ignore: implementation_imports
// import 'package:http/src/response.dart';
// import 'package:http_client_helper/http_client_helper.dart';

// // import 'package:isolate/load_balancer.dart';
// // import 'package:isolate/isolate_runner.dart';
// import 'package:extended_image/extended_image.dart';
// import 'package:image/image.dart';
// import 'package:image_editor/image_editor.dart';

// final Future<LoadBalancer> loadBalancer =
//     LoadBalancer.create(1, IsolateRunner.spawn);

// Future<dynamic> isolateDecodeImage(List<int> data) async {
//   final ReceivePort response = ReceivePort();
//   await Isolate.spawn(_isolateDecodeImage, response.sendPort);
//   final dynamic sendPort = await response.first;
//   final ReceivePort answer = ReceivePort();
//   // ignore: always_specify_types
//   sendPort.send([answer.sendPort, data]);
//   return answer.first;
// }

// void _isolateDecodeImage(SendPort port) {
//   final ReceivePort rPort = ReceivePort();
//   port.send(rPort.sendPort);
//   rPort.listen((dynamic message) {
//     final SendPort send = message[0] as SendPort;
//     final List<int> data = message[1] as List<int>;
//     send.send(decodeImage(data));
//   });
// }

// Future<dynamic> isolateEncodeImage(Image src) async {
//   final ReceivePort response = ReceivePort();
//   await Isolate.spawn(_isolateEncodeImage, response.sendPort);
//   final dynamic sendPort = await response.first;
//   final ReceivePort answer = ReceivePort();
//   // ignore: always_specify_types
//   sendPort.send([answer.sendPort, src]);
//   return answer.first;
// }

// void _isolateEncodeImage(SendPort port) {
//   final ReceivePort rPort = ReceivePort();
//   port.send(rPort.sendPort);
//   rPort.listen((dynamic message) {
//     final SendPort send = message[0] as SendPort;
//     final Image src = message[1] as Image;
//     send.send(encodeJpg(src));
//   });
// }



Future<Uint8List?> cropImageDataWithNativeLibrary(
    {required ExtendedImageEditorState state}) async {
  print('native library start cropping');

  final Rect? cropRect = state.getCropRect();
  final EditActionDetails action = state.editAction!;

  final int rotateAngle = action.rotateAngle.toInt();
  final bool flipHorizontal = action.flipY;
  final bool flipVertical = action.flipX;
  final Uint8List img = state.rawImageData;

  final ImageEditorOption option = ImageEditorOption();

  if (action.needCrop) {
    option.addOption(ClipOption.fromRect(cropRect!));
  }

  if (action.needFlip) {
    option.addOption(
        FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
  }

  if (action.hasRotateAngle) {
    option.addOption(RotateOption(rotateAngle));
  }

  final DateTime start = DateTime.now();
  final Uint8List? result = await ImageEditor.editImage(
    image: img,
    imageEditorOption: option,
  );

  print('${DateTime.now().difference(start)} ：total time');
  return result;
}

