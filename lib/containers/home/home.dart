import 'package:flutter/material.dart';
import '../../components/switchWalletDrawer.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  @override
  void initState() {
    super.initState();
    print('fffdee');
  }

  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  _openDrawer () {
    _key.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final hasAccountWidget =  Scaffold(
      key: _key,
      drawer: MyDrawer(),
      backgroundColor: Color(0xFFf0f2f5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu
          ),
          onPressed: _openDrawer
        ),
        title: Text('钱包啦'),
        centerTitle: true,//标题居中
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Container(
              height: 200.0,
              color: Colors.red,
              child: Text('1', style: TextStyle(color: Colors.white)),
              alignment: Alignment.center,
            ),
            Container(
              height: 200.0,
              color: Colors.grey,
              child: Text('2', style: TextStyle(color: Colors.white)),
              alignment: Alignment.center,
            ),
            Container(
              height: 200.0,
              color: Colors.blue,
              child: Text('3', style: TextStyle(color: Colors.white)),
              alignment: Alignment.center,
            ),
            Container(
              height: 200.0,
              color: Colors.black,
              child: Text('4', style: TextStyle(color: Colors.white)),
              alignment: Alignment.center,
            ),
            Container(
              height: 200.0,
              color: Colors.green,
              child: Text('5', style: TextStyle(color: Colors.white)),
              alignment: Alignment.center,
            ),
            Container(
              height: 200.0,
              color: Colors.purple,
              child: Text('6', style: TextStyle(color: Colors.white)),
              alignment: Alignment.center,
            )
          ],
        )
      )
    );
    return hasAccountWidget;
  }

  @override
  bool get wantKeepAlive => true;
}