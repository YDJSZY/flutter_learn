import 'package:flutter/material.dart';

class Market extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf0f2f5),
      appBar: AppBar(
        title: Text('市场啦'),
        centerTitle: true,//标题居中
      ),
      body: Container(
        child: TextField(
          decoration: InputDecoration(
            hintText: '市场'
          ),
        ),
      )
    );
  }
}