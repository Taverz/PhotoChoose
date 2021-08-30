import 'dart:typed_data';

import 'package:flutter/material.dart';

class PageEditorImage extends StatefulWidget {
  Uint8List image;
  PageEditorImage({Key? key, required this.image}) : super(key: key);

  @override
  _PageEditorImageState createState() => _PageEditorImageState();
}

class _PageEditorImageState extends State<PageEditorImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  alignment: Alignment.centerLeft,
                  onPressed: () {}, icon: Icon(Icons.ac_unit)
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit))
              ],
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
              image: widget.image == null
                  ? null
                  : new DecorationImage(
                      image: new MemoryImage(widget.image),
                    ),
            )),
          ),
          Container(
            color: Colors.white,
            height: 90,
            child: Center(
              child: Container(
                width:MediaQuery.of(context).size.width < 800 ?  MediaQuery.of(context).size.width - 50 : 800,
                child: Center(
                  child: Text(
                    "Подтвердить",
                    style: TextStyle(fontSize: 22, color: Color(0xff536EFC)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
