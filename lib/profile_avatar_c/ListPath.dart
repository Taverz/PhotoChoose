// import 'dart:typed_data';

// import 'package:dsf/animation.dart';
// import 'package:dsf/block/listpath_bloc.dart';
// import 'package:dsf/block/listpath_event.dart';
// import 'package:dsf/block/listpath_state.dart';
// import 'package:dsf/profile_avatar_c/sfer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:photo_manager/photo_manager.dart';

// typedef Meteor  = AssetPathEntity Function(int);
// class ListPathDrop extends StatefulWidget {
//   Meteor? chooisePath;
//   // late ListPathBloc blocOpen;
//   ListPathDrop({Key? key,required ret}) : super(key: key);

//   @override
//   _ListPathDropState createState() => _ListPathDropState();
// }

// class _ListPathDropState extends State<ListPathDrop> {

//   bool _isScrollDown = false;
//   late ListPathBloc _bloPath;
//   late ListPathBloc blocOpen;

//   @override
//   void initState() {
//     _bloPath = ListPathBloc(UninitializedP());
//     blocOpen = ListPathBloc(OpenS());
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _bloPath.close();
//     blocOpen.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//     // Container(
//     //    child: 
//        listNamePath(context);
//     // );
//   }  

//   void stateDrop() {
//     // print("stateDrop");
//     // WidgetsBinding.instance!
//     //     .addPostFrameCallback((_) =>

//     setState(() {
//       print("setState");
//       _isScrollDown = !_isScrollDown;
//     })
//     // )
//       ;
//   }


//     ////////////////////////////////
//     ///
//     ///
    

//     //TODO:

//     // _listNamePath <- listNamePath
//   Widget listNamePath(BuildContext context) {
//     return Expanded(
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         child: FutureBuilder<List<AssetPathEntity>>(
//             future: getNListNamePath(),
//             builder: (context, AsyncSnapshot<List<AssetPathEntity>> assync) {
//               if (assync.hasData) {
//                 return getViewListNamePath(assync.data!);
//               } else if (assync.hasError) {
//                 return Center(
//                   child: SizedBox(
//                     child: Icon(
//                       Icons.error,
//                       color: Colors.red,
//                     ),
//                     width: 60,
//                     height: 60,
//                   ),
//                 );
//               } else {
//                 return Center(
//                   child: SizedBox(
//                     child: CircularProgressIndicator(),
//                     width: 60,
//                     height: 60,
//                   ),
//                 );
//               }
//               // if(platform.isIOS){ // ios progress indicatior }
//               // return CircularProgressIndicator();
//             }),
//       ),
//     );
//   }

//  //TODO:

//     // _getViewListNamePath <- getViewListNamePath
//    Widget getViewListNamePath(List<AssetPathEntity> data) {
//     return ListView.separated(
//         separatorBuilder: (_, __) => Container(
//               margin: const EdgeInsetsDirectional.only(start: 60),
//               height: 3,
//               // color: theme.canvasColor,
//             ),
//         itemCount: data.length,
//         itemBuilder: (context, index) {   

//            return BlocBuilder(
//               bloc: _bloPath,
//               builder: (context, state){
//                   if(state is OpenS) 
//                     return GestureDetector(
//                         onTap: () {
//                           print("выбор папки");
//                           widget.chooisePath!(index); //data[index]  - AssetPathEntity
//                           _bloPath.add(ListElementShooise(index, data));
//                           _bloPath.add(Close());
//                         },
//                         child: getItemListName(data[index]));

//                   return Text("S");
//               },
//             );

//           });

          
//   }

//   // Widget animatoinSwitch(Widget child, Widget child2){
//   //   Animatio
//   //   return BlocListener(
//   //     bloc: mapBloc,
//   //     listener: (context, state) {
//   //       },
//   //     child: BlocBuilder(
//   //       bloc: mapBloc,
//   //       builder: ((BuildContext context, MapStates state) {
//   //           return AnimatedSwitcher(
//   //               duration: const Duration(milliseconds: 1000),
//   //               child: state
//   //                   ? child //Icon(Icons.face, size: 80, key: Key("80"))
//   //                   : child2, //Icon(Icons.face, size: 160, key: Key("160")),
//   //             );
//   //       })
//   //     )
//   //   );
//   // }


//     Widget getItemListName(AssetPathEntity data) {
//     return Container(
//       child: Row(
//         children: [
          
//           SizedBox(width: 5,),
//           FutureBuilder<Uint8List?>(
//             future:getFirstThumbFromPathEntity(data) ,
//             builder: (context,AsyncSnapshot<Uint8List?> snapshot){
//                 return Container(
//                   width: 50,
//                   height: 50,
//                   decoration:  BoxDecoration(
//                       image: snapshot.data == null
//                           ? null
//                           : DecorationImage(
//                               fit: BoxFit.cover,
//                               image: MemoryImage(snapshot.data!),
//                             ),
//                     ),
//                 );
//             }
//           ),
//           SizedBox(width: 8,),
          
//           Container(
//               padding: EdgeInsets.all(8),
//               child: Center(
//                   child: Text(
//                 data.name,
//                 style: TextStyle(fontSize: 18),
//               ))),
//           Spacer(),
//           Container(
//               padding: EdgeInsets.all(8),
//               child: Center(
//                   child: Text(
//                 "(" + data.assetCount.toString() + ")",
//                 style: TextStyle(fontSize: 18),
//               ))),
//         ],
//       ),
//     );
//   }


// ///
// ///  
// ////////////////////////////////
    


 








//   //TODO: click dropDown
//   // Widget clickableListDrop(BuildContext context){
//   //       return  Container(
//   //         color: Colors.tealAccent,
//   //           padding: EdgeInsets.only(top: 8),
//   //           width: 150,
//   //           height: 50,
//   //           child: Column(
//   //             children: [
//   //               GestureDetector(
//   //                 onTap: () => stateDrop, //dropDownCustom(context) ,
//   //                 child: Text("Галерея",
//   //                     style: TextStyle(
//   //                         fontSize: 22,
//   //                         color: Colors.black,
//   //                         fontWeight: FontWeight.bold)),
          
//   //                 // child:
//   //               ),
//   //               Stack(
//   //               children: <Widget>[
//   //                 // child: 
//   //                 Positioned.fill(                  
//   //                   child: Container(
//   //                     color: Colors.purpleAccent,
//   //                     width: 100,
//   //                     height: 100,
//   //                     child: ExpandedSection(
//   //                       child: listNamePath(context),
//   //                       height: 100,
//   //                       expand: _isScrollDown,
//   //                     ),
//   //                   ),
//   //                 ),
                  
//   //                 ]
//   //               ),
//   //             ],
//   //           ),
//   //         );
//   // }










// }


