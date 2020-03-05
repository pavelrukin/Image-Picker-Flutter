import 'package:flutter/material.dart';

import 'ListFavorite.dart';
import 'ListImage.dart';

class DestinationController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DestinationControllerState();
}

class _DestinationControllerState extends State<DestinationController>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _tabController;
  List<Widget> _tabList = [ListImages(), ListFavorite()];

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _tabList.length);
    _tabController.addListener(_tabControllerListener);
    super.initState();

  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(_tabControllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Navigation'),
      ),
      body: TabBarView(
        children: _tabList,
        controller: _tabController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (currentIndex) {
          setState(() {
            _currentIndex = currentIndex;
            _tabController.animateTo(_currentIndex);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('ListImages')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('Favorite')),
        ],
      ),
    );
  }
}
