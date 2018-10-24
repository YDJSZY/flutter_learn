import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'switchWalletDrawer.dart';
import 'redux/index.dart';
import 'redux/actions.dart';

void main() {
  final store = globalState;
  runApp(new MyApp(store: store));//传入store
}

class MyApp extends StatelessWidget {
  final Store store;
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  _openDrawer () {
    _key.currentState.openDrawer();
  }

  MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<dynamic> (
      store: store,
      child: MaterialApp(
        title: 'Container',
        theme: ThemeData(
          primaryColor: Colors.white
        ),
        home: new Scaffold(
          key: _key,
          drawer: MyDrawer(),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.menu
              ),
              onPressed: _openDrawer,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('redux')
              ],
            ),
          ),
          body: Container(
            color: Colors.red,
            child: Row(
              children: <Widget>[
                new StoreConnector<dynamic, String>(
                  converter: (count) => store.state.transactionRecord.count.toString(),
                  builder: (context, count) {
                    return new Text(
                      count,
                      style: Theme.of(context).textTheme.display1,
                    );
                  },
                )
              ],
            ),
          ),
          floatingActionButton: new StoreConnector<dynamic, VoidCallback>(
            converter: (store) {
              // Return a `VoidCallback`, which is a fancy name for a function
              // with no parameters. It only dispatches an Increment action.
              return () => store.dispatch({'type': Actions.SetMyInfo, 'data': {'username': 'lww', 'age': '26'}});
            },
            builder: (context, callback) {
              return new FloatingActionButton(
                // Attach the `callback` to the `onPressed` attribute
                onPressed: callback,
                tooltip: 'SetCount',
                child: new Icon(Icons.add),
              );
            },
          ),
        )
        /*decoration: BoxDecoration(
          gradient: LinearGradient(//背景渐变
            colors: [Colors.lightBlue, Colors.greenAccent,Colors.purple]
          )
        ),*/ 
      ),
    );
    
  }
}
