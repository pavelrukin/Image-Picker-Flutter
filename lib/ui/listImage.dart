
import 'package:flutter/material.dart';
import 'package:flutter_test_image_picker/api/webService.dart';
import 'package:flutter_test_image_picker/ui/imageScreen.dart';
import 'package:flutter_test_image_picker/model/dataResponse.dart';

class ListImages extends StatefulWidget {
  @override
  createState() => ListImagesState();

}

class ListImagesState extends State<ListImages> {
  List<DataResponse> listDataResponse;

  @override
  void initState() {
    super.initState();
    _populateDataResponse();
  }

  void _populateDataResponse() {
    WebService().load(DataResponse.all).then((dataResponse) => {
          setState(() => {listDataResponse = dataResponse})
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
      ),
      body: ListView.builder(
        itemCount: listDataResponse.length,
        itemBuilder: _buildItemsForListView,
      ),
      // body:
    );
  }
  Widget _buildItemsForListView(BuildContext context, int index){
var allData = listDataResponse[index];
var name = allData.user.name;
var imageUrl = allData.urls.thumb;
var description = allData.description;


    return ListTile(
     // _dataResponse[index].description == null? "Empty description" : _dataResponse[index].description,maxLines: 2,
      title: Text(description == null ? "Empty desription" : description, maxLines: 2,),
      subtitle: Text(name),
      leading: Material(
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ImageScreen(
              imgUrl:imageUrl,
            author: name,)));
          } ,
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(imageUrl),
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
