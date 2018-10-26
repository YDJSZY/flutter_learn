import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../pages/noWallet/index.dart';
import './home.dart';

class HomeWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<dynamic, String>(
      converter: (store) => store.state.accounts.selectAccount,
      builder: (context, selectAccount) {
        if (selectAccount == '') return NoWallet();//如果当前没有任何选择账户，则跳转到提示创建
        return Home();
      });
  }
}