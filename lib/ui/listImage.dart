import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_image_picker/api/webService.dart';
import 'package:flutter_test_image_picker/ui/imageScreen.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_test_image_picker/model/dataResponse.dart';

class ListImages extends StatefulWidget {
  @override
  createState() => ListImagesState();

}

class ListImagesState extends State<ListImages> {
  List<DataResponse> _dataResponse;

  @override
  void initState() {
    super.initState();
    _populateDataResponse();
  }

  void _populateDataResponse() {
    WebService().load(DataResponse.all).then((dataRespnse) => {
          setState(() => {_dataResponse = dataRespnse})
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
      ),
      body: ListView.builder(
        itemCount: _dataResponse.length,
        itemBuilder: _buildItemsForListView,
      ),
      // body:
    );
  }
  Widget _buildItemsForListView(BuildContext context, int index){
    return ListTile(
      title: Text(_dataResponse[index].description == null? "Empty description" : _dataResponse[index].description,maxLines: 2, ),
      subtitle: Text("Author : "+ _dataResponse[index].user.name),
      leading: Material(
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ImageScreen(
              imgUrl: _dataResponse[index].urls.thumb,
            author: _dataResponse[index].user.name,)));
          } ,
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(_dataResponse[index].urls.thumb),
            backgroundColor: Colors.transparent,
          ),
        ),
      ) ,
    );

  }
}
/*   Workig TileWidg
Widget _buildItemsForListView(BuildContext context, int index) {
  return ListTile(

    dense: true,

    subtitle: Text(
      _dataResponse[index].user.name,
      style: TextStyle(fontSize: 18),
    ),
  );*/
