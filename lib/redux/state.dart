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

class AppState {
  MyInfo myInfo;
  TransactionRecord transactionRecord;
  CurrentMainPage currentMainPage;

  AppState({
    this.myInfo, 
    this.transactionRecord, 
    this.currentMainPage
  });
}