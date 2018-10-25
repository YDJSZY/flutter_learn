import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

setBoxDecoration (String n, String eqNum) {
  if (n == eqNum) {
    return BoxDecoration(
        border: Border(left: BorderSide(width: 5.0, color: Color(0xFF000000)))
      );
  }
  return null;
}

setBackgroundColor (String n, String eqNum) {
  if (n == eqNum) {
    return Color(0x20000000);
  }
  return Color(0xFFFFFFFF);
}

List<Widget> setAccountsItem (List<String> data, cb, String eqNum) {
  List<Widget> accountItems = [];
  for (var item in data) {
    accountItems.add(
      GestureDetector(
        onTap: () {
          cb(item);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(35.0, 25.0, 35.0, 25.0),
          foregroundDecoration: setBoxDecoration(item, eqNum),
          color: setBackgroundColor(item, eqNum),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[ 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                    child: Text(
                      'PUT-Wallet',
                      style: TextStyle(
                        color: Color(0xFF3B3B43),
                        fontSize: 22.0
                      ),
                    ),
                  ),
                  Text(
                    item,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF8C8C8C)
                    )
                  )
                ],
              ),
              Text(
                '...',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF3B3B43)
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  return accountItems;
}

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var eqNum = '1';
  @override
  void initState() {
    eqNum = '1';
    super.initState();
  }

  changeEqNum (String eq) {
    print('2222');
    setState(() {
      eqNum = eq;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget>accounts = setAccountsItem(['1', '2'], changeEqNum, eqNum);
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 160.0,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/wallet.png',
                    width: 36.0,
                    fit: BoxFit.cover,//BoxFit.cover 告诉框架，图像应该尽可能小，但覆盖整个渲染框
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        new StoreConnector<dynamic, Map>(
                          converter: (store) => store.state.myInfo.infos,
                          builder: (context, infos) {
                            print(infos);
                            return Text(
                              infos['username'],
                              style: TextStyle(
                                color: Color(0xFF3B3B43),
                                fontSize: 18.0
                              ),
                            );
                        }),
                        new StoreConnector<dynamic, String>(
                          converter: (store) => store.state.transactionRecord.order.toString(),
                          builder: (context, order) {
                            print(order);
                            return new Text(
                              order,
                              style: Theme.of(context).textTheme.display1,
                            );
                          },
                        )
                      ] 
                    )
                  )
                ],
              ),
              color: Colors.white,
            ), // 可在这里替换自定义的header
            Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: accounts,
            )
          ),
          ],
        )
      ),
    );
  }
}