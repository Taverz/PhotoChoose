import 'dart:typed_data';

import 'package:dsf/block/profileimage_block.dart';
import 'package:dsf/block/profileimage_event.dart';
import 'package:dsf/block/profileimage_state.dart';
import 'package:dsf/profile_avatar_c/image_demo_editor.dart';
import 'package:dsf/profile_avatar_c/page_editor_image.dart';

import 'package:dsf/profile_avatar_c/sfer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

class MenuView extends StatefulWidget {
  MenuView({Key? key}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> with TickerProviderStateMixin {
  late ProfileImageBloc _bloc;

  @override
  void initState() {
    _bloc = ProfileImageBloc(ChooseNo());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buttonSheetCustom(context);
  }

  bool _isTapDropDown = false;

  Widget buttonSheetCustom(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 0),
      child: Expanded(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,

                    // padding: EdgeInsets.only(right: 15),
                  ),
                  Spacer(),
                  // clickableListDrop(context),

                  BlocBuilder(
                    bloc: _bloc,
                    builder: (context, state) =>
                        // if(state is )return;
                        // return
                        GestureDetector(
                      onTap: () {
                        // stateDrop();
                        if (state is OpenListPath) {
                          _bloc.add(CloseEvent());
                        } else if (state is CloseListPath) {
                          _bloc.add(OpenEvent());
                        } else {
                          _bloc.add(OpenEvent());
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 170,
                        // height: 40,
                        color: Colors.transparent,
                        child: Text("Галерея",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),

                  Spacer(),

                  IconButton(
                      alignment: Alignment.centerRight,
                      iconSize: 30,
                      onPressed: () {
                        _dataChoise;
                        Navigator.pop(context, _dataChoise);
                      },
                      icon: Icon(Icons.close))
                ],
              ),
            ),
            Expanded(
                child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: BlocBuilder(
                          bloc: _bloc,
                          builder: (context, state) {
                            if (state is CloseListPath) {
                              if (state.index == null) {
                                return gridViewFuture(context, 0);
                              } else {
                                return gridViewFuture(context, state.index!);
                              }
                            }
                            return gridViewFuture(context, 0);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BlocBuilder(
                        bloc: _bloc,
                        builder: (context, state){
                         // child: 
                        if(state is Chosen){
                          return
                          buttonA(context, true, image: state.imageBytes );
                        } 
                        return buttonA(context, false);
                        // GestureDetector(
                        //   onTap: () {
                        //     if(state is Chosen){
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) =>
                                
                        //            PageEditorImage(image:state.imageBytes ,)
                        //         ),
                        //       ); 
                        //     }
                            
                        //   },
                        //   child: Container(
                        //     // alignment: Alignment.bottomCenter,
                        //     // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        //     color: Colors.white,
                        //     child: Center(
                        //       child: Container(
                        //         height: 50,
                        //         width: MediaQuery.of(context).size.width < 800
                        //             ? MediaQuery.of(context).size.width
                        //             : 800,
                        //         decoration: BoxDecoration(
                        //             borderRadius:
                        //                 BorderRadius.all(Radius.circular(8.0)),
                        //             //TODO: HEX color
                        //             color: false
                        //                 ? Color(0xff536EFC)
                        //                 : Color(0xff949FDA)),
                        //         child: Center(
                        //           child: Text(
                        //             "Далее",
                        //             style: TextStyle(
                        //                 fontSize: 24, color: Colors.white),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // );
                        }
                      ),
                    ],
                  ),
                ),
                BlocBuilder(
                  bloc: _bloc,
                  builder: (context, state) => Visibility(
                      visible: state is OpenListPath,
                      child: Positioned.fill(
                        child: Container(
                            color: Colors.white, child: listNamePath(context)),
                      )),
                )
              ],
            )),
            SizedBox(height: 20),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget buttonA(BuildContext context, bool click, {Uint8List? image} ){
           return     
            GestureDetector(
                onTap: () {
                  if(click == true){
                    //  if(state is Chosen){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        SimpleImageEditor(image!),
                        // ImageEditorDemo(image!),
                        //  PageEditorImage(image:image! ,)
                      ),
                    ); 
                  // }
                  }else{
                    //показать toast
                  }

                 
                  
                },
                child: Container(
                  // alignment: Alignment.bottomCenter,
                  // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width < 800
                          ? MediaQuery.of(context).size.width
                          : 800,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                          //TODO: HEX color
                          color: click
                              ? Color(0xff536EFC)
                              : Color(0xff949FDA)),
                      child: Center(
                        child: Text(
                          "Далее",
                          style: TextStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              );
  }

  //TODO:

  // _listNamePath <- listNamePath
  Widget listNamePath(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<List<AssetPathEntity>>(
            future: getNListNamePath(),
            builder: (context, AsyncSnapshot<List<AssetPathEntity>> assync) {
              if (assync.hasData) {
                return getViewListNamePath(assync.data!);
              } else if (assync.hasError) {
                return Center(
                  child: SizedBox(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    width: 60,
                    height: 60,
                  ),
                );
              } else {
                return Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                );
              }
              // if(platform.isIOS){ // ios progress indicatior }
              // return CircularProgressIndicator();
            }),
      ),
    );
  }

  // _getViewListNamePath <- getViewListNamePath
  Widget getViewListNamePath(List<AssetPathEntity> data) {
    return ListView.separated(
        separatorBuilder: (_, __) => Container(
              margin: const EdgeInsetsDirectional.only(start: 60),
              height: 3,
              // color: theme.canvasColor,
            ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              // if(state is OpenListPath)
              //TODO: при нажати ни чего не изменяется
              return GestureDetector(
                  onTap: () {
                    print("выбор папки");
                    // widget.chooisePath!(index); //data[index]  - AssetPathEntity
                    _bloc.add(ListPathChoise(index, data));
                    // _bloc.add(CloseEvent());
                  },
                  child: getItemListName(data[index]));

              // return Text("S");
            },
          );
        });
  }

  Widget getItemListName(AssetPathEntity data) {
    // data.name;
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 5,
          ),
          FutureBuilder<Uint8List?>(
              future: getFirstThumbFromPathEntity(data),
              builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: snapshot.data == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(snapshot.data!),
                          ),
                  ),
                );
              }),
          SizedBox(
            width: 8,
          ),
          Container(
              padding: EdgeInsets.all(8),
              child: Center(
                  child: Text(
                data.name,
                style: TextStyle(fontSize: 18),
              ))),
          Spacer(),
          Container(
              padding: EdgeInsets.all(8),
              child: Center(
                  child: Text(
                "(" + data.assetCount.toString() + ")",
                style: TextStyle(fontSize: 18),
              ))),
        ],
      ),
    );
  }

  Widget gridViewFuture(BuildContext context, int choise) {
    return FutureBuilder<List<AssetEntity>?>(
        future: loadAssetList(0),
        builder: (context, AsyncSnapshot<List<AssetEntity>?> assync) {
          if (assync.hasData) {
            return getGridView(assync.data!);
          } else if (assync.hasError) {
            return Center(
              child: Container(
                height: 60,
                width: 60,
                child: SizedBox(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  width: 50,
                  height: 50,
                ),
              ),
            );
          } else {
            return Center(
              child: Container(
                height: 60,
                width: 60,
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 50,
                  height: 50,
                ),
              ),
            );
          }
          // if(platform.isIOS){ // ios progress indicatior }
          // return CircularProgressIndicator();
        });
  }

  Widget getGridView(List<AssetEntity> data) {
    return

        // SliverGrid(
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 3,
        //     ),
        //     delegate: SliverChildBuilderDelegate(
        //       (BuildContext context, int index) => getItemGrid(data[index], context),
        //   )
        // );

      GridView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            // TODO: при выборе не убирается отметка

            if (state is Chosen) {
              if (state.index != null) {
                return getItemGrid(data[index], index, context,
                    state.index == index ? true : false);
              } else {
                return getItemGrid(data[index], index, context, false);
              }
            }
            return getItemGrid(data[index], index, context, false);
          }),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        // childAspectRatio: 0,
      ),
    );
  }

  int _selectN = 09090;
  Uint8List? _dataChoise = null;

  Widget getItemGrid(
      AssetEntity data, int index, BuildContext context, bool choiseB) {
        //TODO: favorit
        // data.isFavorite = true;
        
    return
        // GestureDetector(
        //   onTap: () async {
        //     Uint8List? byte = await getImg(data);
        //     // choiseSet(data2!, index);
        //     _bloc.add(GridElementChoose(index, byte!)); //

        //     // _bloc.choiseElement( index);
        //   },
        //   child:
        //TODO: не изменяется размер
        BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              
              return AnimatedSize(
                vsync: this,
                //MyAnimatedSizeWidget(
                duration: const Duration(seconds: 1),
                child: FutureBuilder(
                    future: getImg(data),
                    builder: (context, AsyncSnapshot<Uint8List?> assyn) {
                      return GestureDetector(
                        onTap: () async {
                          // Uint8List? byte = await getImg(data);
                          // choiseSet(data2!, index);
                          if(state is Chosen){
                            if(state.index == index){
                                _bloc.add(GridElementChooseNO());
                            }
                          } else if( state is ChooseNo){
                                _bloc.add(GridElementChoose(index, assyn.data!)); 
                          }
                          

                          // _bloc.choiseElement( index);
                        },
                        child: Container(
                          width:  100,
                            height:  100,
                          child: Container(
                            width: choiseB ? 85 : 100,
                            height: choiseB ? 85 : 100,
                            child: Stack(
                              children: [
                                //Image
                                Positioned(
                                    child:
                                        // FutureBuilder<Uint8List?>(
                                        //     future: getImg(data),
                                        //     builder: (context, AsyncSnapshot<Uint8List?> async) =>
                                        // GestureDetector(
                                        //   onTap: (){
                                        //       //Препросмотр
                                        //   },
                                        //   child:
                                        getImage(assyn.data)
                                    // )
                                    // )
                                    ),
                                //Пометить что он выбран
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  // child: GestureDetector(
                                  //   onTap: (){
                                  //       // просто выбор
                                  //   },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: choiseB
                                          ? Icon(
                                              Icons.check_circle,
                                              color: Colors.blue,
                                            )
                                          : Icon(
                                              Icons.radio_button_unchecked,
                                              color: Colors.white,
                                            ),
                                    ),
                                  ),
                                  // )
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            });

    // );
  }

  Future<Uint8List?> getImg(AssetEntity data) async {
    Uint8List? bytes = await data.thumbDataWithSize(150, 150);
    return bytes;
  }

  Widget getImage(Uint8List? bytes) {
    // Uint8List? bytes = await data.thumbDataWithSize(30 ,30 );

    return
        
      Container(
      // width: 150,
      // height: 150,
      decoration: BoxDecoration(
        image: bytes == null
            ? null
            : DecorationImage(
                fit: BoxFit.cover,
                image: MemoryImage(bytes),
              ),
      ),
    );
  }
}

class MyAnimatedSizeWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const MyAnimatedSizeWidget({
    Key? key,
    required this.child,
    required this.duration,
  }) : super(key: key);

  @override
  _AnimatedSizeWidgetState createState() => _AnimatedSizeWidgetState();
}

class _AnimatedSizeWidgetState extends State<MyAnimatedSizeWidget>
    with TickerProviderStateMixin {
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      duration: widget.duration,
      child: widget.child,
      curve: Curves.easeInOut,
    );
  }
}
