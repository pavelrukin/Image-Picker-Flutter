import 'package:flutter/material.dart';
import 'package:flutter_test_image_picker/api/WebService.dart';
import 'package:flutter_test_image_picker/ui/DetailItem.dart';
import 'package:flutter_test_image_picker/ui/ImageScreen.dart';
import 'package:flutter_test_image_picker/model/DataResponse.dart';

class ListImages extends StatefulWidget {
  ListImages({Key key}) : super(key: key);

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
    WebService().load(DataResponse.all).then((dataResponse) => {
          setState(() => {_dataResponse = dataResponse})
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildRequestListView());
  }

  Widget _buildRequestListView() {
    if (this._dataResponse != null) {
      return ListView.builder(
        itemCount: _dataResponse.length,
        itemBuilder: _buildItemsForListView,
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildItemsForListView(BuildContext context, int index) {
    var allData = _dataResponse[index];
    var name = allData.user.name;
    var imageUrl = allData.urls.thumb;
    var description = allData.description;

    return ListTile(
      onTap: () {
        allData.iddd= index;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailItem(
                    dataResponse: allData, iddd: index,
                  )),
        );
      },
      title: Text(
        description == null ? "Empty desription" : description,
        maxLines: 2,
      ),
      subtitle: Text(name),
      leading: Material(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImageScreen(
                          imgUrl: imageUrl,
                          author: name,
                        )));
          },
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(imageUrl),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
