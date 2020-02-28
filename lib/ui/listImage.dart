import 'package:flutter/material.dart';
import 'package:flutter_test_image_picker/api/webService.dart';

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

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      subtitle: Text(
        _dataResponse[index].user.name,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
