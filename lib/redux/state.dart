import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyInfo {
  Map infos;
  MyInfo(this.infos);
}

class TransactionRecord {
  int order;
  int count;
  TransactionRecord({this.order: 0, this.count: 0});
}

class CurrentMainPage {
  int currentPageIndex = 0;
  CurrentMainPage({this.currentPageIndex});
}

class Accounts {
  String selectAccount = '';
  List accountNames = [];
  Map accountsDetail = {};

  Accounts({this.selectAccount: '', this.accountNames, this.accountsDetail});
}

class SharePres {
  SharedPreferences sharePres;

  SharePres({this.sharePres});

  setStringData (key, value) async {
    await sharePres.setString(key, value);
    var secretData = sharePres.getString(key);
    print('保存了');
    print(secretData);
  }

  setSharePresMap (key, value) {
    String val = json.encode(value);//map to string
    sharePres.setString(key, val);
  }
}

class AppState {
  MyInfo myInfo;
  TransactionRecord transactionRecord;
  CurrentMainPage currentMainPage;
  Accounts accounts;
  SharePres sharePres;

  AppState({
    this.myInfo, 
    this.transactionRecord, 
    this.currentMainPage,
    this.accounts,
    this.sharePres
  });
}