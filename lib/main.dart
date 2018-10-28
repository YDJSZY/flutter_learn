import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'redux/index.dart';
import 'redux/actions.dart';
import 'containers/index.dart';

void main() async {
  final store = await init();
  runApp(new MyApp(store: store));//传入store
}

class MyApp extends StatelessWidget {
  final Store store;

  MyApp({Key key, this.store}) : super(key: key);

  setCurrentPageIndex (int index) {
    store.dispatch({'type': Actions.SetCurrentPageIndex, 'data': index});
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<dynamic> (
      store: store,
      child: MaterialApp(
        title: '钱包APP',
        theme: ThemeData(
          primaryColor: Colors.white
        ),
        home: new Scaffold(
          backgroundColor: Color(0xFFf0f2f5),
          body: new StoreConnector<dynamic, int>(
            converter: (index) => store.state.currentMainPage.currentPageIndex,//转换从redux拿回来的值
            builder: (context, index) {
              print(index);
              return IndexedStack(
                index: index,
                children: mainPages
              );
            },
          ), 
          bottomNavigationBar: new StoreConnector<dynamic, int>(
            converter: (index) => store.state.currentMainPage.currentPageIndex,
            builder: (context, index) {
              return BottomNavigationBar(
                fixedColor: Color(0xFF3B3B43),//当前路由被选中的颜色
                currentIndex: index,
                onTap: setCurrentPageIndex, // 触发redux，选择当前页面index
                items: [
                  BottomNavigationBarItem(
                    backgroundColor: Color(0xFF8C8C8C),
                    icon: new Icon(Icons.home),
                    title: new Text('Home'),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Color(0xFF8C8C8C),
                    icon: new Icon(Icons.mail),
                    title: new Text('Messages'),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Color(0xFF8C8C8C),
                    icon: Icon(Icons.person),
                    title: Text('Profile')
                  )
                ],
              );
            },
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
        ),
        routes: <String, WidgetBuilder> {
        },
        /*decoration: BoxDecoration(
          gradient: LinearGradient(//背景渐变
            colors: [Colors.lightBlue, Colors.greenAccent,Colors.purple]
          )
        ),*/ 
      ),
    );
    
  }
}
