import 'package:dsf/profile_avatar_c/sfer.dart';
import 'package:flutter/material.dart';
// import 'package:imageq/imape_Page.dart';
// import 'package:imageq/oze/assetpicker.dart';

// import 'dart:typed_data';

// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/widgets.dart';
import 'package:photo_manager/photo_manager.dart';




import 'dart:io';
import 'dart:typed_data';

// import 'package:extended_image/extended_image.dart';
import 'package:flutter/widgets.dart';
// import 'package:photo_manager/photo_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title:
              'Flutter Demo Home Page'), //Screen2ImageChooise() ,// MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width ,
                child: FutureBuilder<List<AssetPathEntity>>(
                    future: getNListNamePath(),
                    builder:(context, AsyncSnapshot<List<AssetPathEntity>> assync) {
                      // if(assync.hasData){
            
                      // }
                      // if(platform.isIOS){ // ios progress indicatior }
                      // return CircularProgressIndicator();
                      return getViewListNamePath(assync.data!);
                  
                    }),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width ,
                child: FutureBuilder<List<AssetEntity>?>(
                    future: loadAssetList(0),
                    builder: (context, AsyncSnapshot<List<AssetEntity>?> assync) {
                       // if(assync.hasData){
            
                      // }
                      // if(platform.isIOS){ // ios progress indicatior }
                      // return CircularProgressIndicator();
                      return getGridView(assync.data!);               
                    }),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            // Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



 bool _select = false;

  Widget getViewListNamePath(List<AssetPathEntity> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return getItemListName(data[index]);
        });
  }

  Widget getItemListName(AssetPathEntity data) {
    return Row(
      children: [
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
    );
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
      itemBuilder: (context, index) => getItemGrid(data[index], context), //Container(color: Colors.blue[((index) % 9) * 100]),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        // childAspectRatio: 0,
      ),
    );

  }

 
  Widget getItemGrid(AssetEntity data , BuildContext context){
    return
    Container(
      width: 150,
      height: 150,
      child: Stack(children: [
        //Image
        Positioned(
          child: FutureBuilder<Uint8List?>(
            future: getImg(data), 
            builder: (context, AsyncSnapshot<Uint8List?> async)=>getImage(async.data)
            )
          //  getImage(data)
        ),
        //Liked
        Positioned(
          top: 5,
          right: 5,
          child: 
          Container(
            width: 30,
            height: 30,
            child: IconButton(
              onPressed: (){
                // if(_select == false){
                //    _select = true;
                //    imageSelect(data);
                // }else{
                //   _select = false;
                // }
                
                  
              },
              icon: _select ? 
                Icon(Icons.check_circle) :
                Icon(Icons.check_circle_outline) 
              ,
            ),
          )
        )
      ],),
    );
  }

  Future<Uint8List?> getImg(AssetEntity data) async {
    Uint8List? bytes = await data.thumbDataWithSize(150 ,150 );
    return bytes;
  }
  Widget getImage(Uint8List? bytes)  {
    // Uint8List? bytes = await data.thumbDataWithSize(30 ,30 );



    return 
    // final decoration = new BoxDecoration(
    //   image: bytes == null ? null :
    //   new DecorationImage(
    //     image: new MemoryImage(bytes),
    //   ),
    // );

    Container(
      // width: 150,
      // height: 150,
      decoration: BoxDecoration(
      image: bytes == null ? null :
      new DecorationImage(
        image: new MemoryImage(bytes),
      ),
      ),
    );
      
  }





}
