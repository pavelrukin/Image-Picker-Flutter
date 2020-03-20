import 'package:flutter/material.dart';
import 'package:flutter_test_image_picker/db/DBProvider.dart';
import 'package:flutter_test_image_picker/model/DataResponse.dart';

class ListFavorite extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListFavoriteState();
}
int id;



class _ListFavoriteState extends State<ListFavorite> {

  List<DataResponse> _dataResponse = List<DataResponse>();

  DBProvider _dbProvider ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbProvider.initDB();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite"),),
      body: ListView.builder(
        itemCount:  _dataResponse.length,
          itemBuilder: (context,index){
            return ListTile(
              title: Text(_dataResponse[index].user.name),
            );
          }),
    );
  }

}