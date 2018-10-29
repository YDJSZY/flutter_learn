import 'package:flutter/material.dart';

class CreateWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text('创建钱包'),
        centerTitle: true,//标题居中
      ),
    );
  }
}