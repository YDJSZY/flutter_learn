import 'package:redux/redux.dart';
import 'state.dart';
import 'reducers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
Map prefsInitData = {'selectAccount': '', 'accountNames': [], 'accountsDetail': {}};
var globalState;

initPreferences () async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //if (prefs.getString('walletData') != null) return prefs;
  String walletData = json.encode(prefsInitData);//map to string
  await prefs.setString('walletData', walletData);
  return prefs;
}
init () async {
  SharedPreferences prefs = await initPreferences();
  String walletData = prefs.getString('walletData');
  Map mapWalletData = json.decode(walletData);//string to map
  print(mapWalletData);
  globalState = new Store<AppState>(mainReducer, initialState: new AppState(
    myInfo: new MyInfo({'username': 'ydjs'}),
    transactionRecord: new TransactionRecord(order: 11),
    currentMainPage: new CurrentMainPage(currentPageIndex: 0),
    accounts: new Accounts(selectAccount: '', accountNames: [], accountsDetail: {}),
  ));
  return globalState;
}
