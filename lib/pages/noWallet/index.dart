import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class NoWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text('钱包'),
        centerTitle: true,//标题居中
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 46.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                Image.asset(
                  'images/wallet.png',
                  width: 116.0,
                  height: 131.0,
                  fit: BoxFit.cover,//BoxFit.cover 告诉框架，图像应该尽可能小，但覆盖整个渲染框
                ),
                Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Text(
                    '暂无钱包', 
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF3B3B43)
                    ),
                  )
                )
              ]
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(75.0, 0, 75.0, 170.0),
              child: RaisedButton(
                padding: EdgeInsets.only(top: 13.0, bottom: 13.0),
                onPressed: () => {},
                color: Color(0xFF3B3B43),
                child: Text(
                  '创建钱包',
                  style: TextStyle(
                    color: Colors.white
                  )
                ),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
              ),
            )
            
          ]
        ),
      )
    );
  }
}