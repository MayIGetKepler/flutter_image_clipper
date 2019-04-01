import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'image_clipper.dart';

const String pic = 'https://avatars0.githubusercontent.com/u/45789654?s=460&v=4';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ImageClipper Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ImageClipper clipper;

    clip()async{
     ui.Image _image;
    _imageLoader().then((image){_image = image;}).whenComplete((){
       clipper =  ImageClipper(_image);
       setState(() {});
    });
  }

  Future<ui.Image> _imageLoader() {
    ImageStream imageStream = NetworkImage(pic)
        .resolve(ImageConfiguration.empty);
    Completer<ui.Image> imageCompleter = Completer<ui.Image>();
    void imageListener(ImageInfo info, bool synchronousCall) {
      ui.Image image = info.image;
      imageCompleter.complete(image);
      imageStream.removeListener(imageListener);
    }

    imageStream.addListener(imageListener);
    return imageCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ImageClipper'),
        ),
        body: Center(
                  child: Column(
            children: <Widget>[
              SizedBox(child: Container(color: Colors.grey, child: Image.network(pic)),width: 100,height: 150,),
              SizedBox(height: 50,),
              Container(color: Colors.green,child: CustomPaint(painter: clipper,size: Size(50, 50),)),
              RaisedButton(child: Text('Clip'),onPressed: ()=>clip())
            ],
          ),
        ),);
  }
}
