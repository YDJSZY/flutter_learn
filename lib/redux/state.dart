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

class AppState {
  MyInfo myInfo;
  TransactionRecord transactionRecord;
  CurrentMainPage currentMainPage;
  Accounts accounts;
  AppState({
    this.myInfo, 
    this.transactionRecord, 
    this.currentMainPage,
    this.accounts
  });
}