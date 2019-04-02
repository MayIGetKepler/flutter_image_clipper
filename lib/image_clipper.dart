import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ImageClipper extends CustomPainter {
  final ui.Image _image;
  ///[left],[top],[right],[bottom]  the proportion of the source image to clip
  ///example left:0.1,top:0.3,right:0.3,bottom:0.6 
  ///will clip a rect from (0.1*source image.width,0.3*source image.width) to (0.3*source image.height,0.6*image.height) 

  final double left;
  final double top;
  final double right;
  final double bottom;

  ImageClipper(this._image,{this.left = 0.35,this.top = 0.35,this.right = 0.6,this.bottom = 0.6});
  
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    canvas.drawImageRect(_image, Rect.fromLTRB(_image.width*left, _image.height*top, _image.width*right, _image.height*bottom), 
    Rect.fromLTWH(0, 0, size.width,  size.height), paint);
  }

  @override
  bool shouldRepaint(ImageClipper oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ImageClipper oldDelegate) => false;
}
