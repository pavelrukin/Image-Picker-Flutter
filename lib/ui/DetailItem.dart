import 'package:flutter/material.dart';
import 'package:flutter_test_image_picker/model/DataResponse.dart';

class DetailItem extends StatefulWidget {
  final String imgUrl;
  final String description;
  final String author;
  final DataResponse dataResponse;



  DetailItem(
      {Key key, this.imgUrl, this.description, this.author, this.dataResponse});
  @override
  createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem>{
  bool _isFavorited = false;
  int _favoriteCount = 0;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 256,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      widget.dataResponse.urls.small,
                      fit: BoxFit.cover,
                    ),
                    const DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment(0.0, -1.0),
                                end: Alignment(0.0, -0.4),
                                colors: <Color>[
                                  Color(0x60000000),
                                  Color(0x0000000)
                                ]))),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      child: Container(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.assignment_ind,
                              size: 40,
                            ),
                            Text(widget.dataResponse.user.name)
                          ],
                        ),
                      ),
                    ),
                    Positioned(right: 0,
                    bottom: 10,
                    child: Container(
                     /// color:Color.fromRGBO(255, 255, 255, 0.5) ,
                      child: Row( children: <Widget>[
                        IconButton(
                          //TODO add favorite item to ListFavovorite
                          icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
                          iconSize: 45,
                          color: Colors.red[100],
                          onPressed: _toggleFavorite,
                        ),
                      ],),
                    ),)
                  ],
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: Text('${widget.dataResponse.description} $index'),
                  );
                },
                childCount: 100,
              ),
            ),
          ],
        ));
  }



}
