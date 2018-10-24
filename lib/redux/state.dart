class MyInfo {
  Map infos;

  MyInfo(this.infos);
}

class TransactionRecord {
  int order;
  int count;
  TransactionRecord({this.order: 0, this.count: 0});
}

class AppState {
  MyInfo myInfo;
  TransactionRecord transactionRecord;

  AppState({this.myInfo, this.transactionRecord});
}