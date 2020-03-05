import 'package:flutter/material.dart';
import 'package:flutter_test_image_picker/model/DataResponse.dart';

class ImageScreen extends StatefulWidget {

  final String imgUrl;
  final String author;

  ImageScreen({Key key, this.imgUrl, this.author  }) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Author :" + widget.author),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.imgUrl),
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }}