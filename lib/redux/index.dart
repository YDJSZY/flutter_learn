import 'package:redux/redux.dart';
import 'state.dart';
import 'reducers.dart';
import '../sharedPreferences.dart';
import 'dart:convert';

var globalState;

init () async {
  var prefs = await initPreferences();
  String walletData = prefs.getString('walletData');
  Map mapWalletData = json.decode(walletData);//string to map
  print(mapWalletData);
  globalState = new Store<AppState>(mainReducer, initialState: new AppState(
    myInfo: new MyInfo({'username': 'ydjs'}),
    transactionRecord: new TransactionRecord(order: 11),
    currentMainPage: new CurrentMainPage(currentPageIndex: 0),
    accounts: new Accounts(selectAccount: '', accountNames: [], accountsDetail: {}),
    sharePres: new SharePres(sharePres: prefs)
  ));
  return globalState;
}
