import 'package:flutter/material.dart';
import 'package:flutter_test_image_picker/api/webService.dart';
import 'package:flutter_test_image_picker/ui/imageScreen.dart';
import 'package:flutter_test_image_picker/model/dataResponse.dart';

class ListImages extends StatefulWidget {
  ListImages({Key key}) : super (key: key);
  @override
  createState() => ListImagesState();

}

class ListImagesState extends State<ListImages> {
  List<DataResponse> _dataResponse;

  @override
  void initState() {
    super.initState();
    if(_dataResponse == null){
      _populateDataResponse();
    }

  }

  void _populateDataResponse() {
    WebService().load(DataResponse.all).then((dataResponse) => {
          setState(() => {_dataResponse = dataResponse})
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
        //The getter 'length' was called on null. //Receiver: null//Tried calling: length
        itemCount: _dataResponse.length == null ? 0: _dataResponse.length,
        itemBuilder: _buildItemsForListView,
      ),
      // body:
    );
  }

  Widget _buildItemsForListView(BuildContext context, int index) {
    var allData = _dataResponse[index];
    var name = allData.user.name;
    var imageUrl = allData.urls.thumb;
    var description = allData.description;

    return ListTile(
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

