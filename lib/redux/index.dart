import 'package:redux/redux.dart';
import 'state.dart';
import 'reducers.dart';

Store<AppState> globalState = new Store<AppState>(mainReducer, initialState: new AppState(
    myInfo: new MyInfo({'username': 'ydjs'}),
    transactionRecord: new TransactionRecord(order: 11),
    currentMainPage: new CurrentMainPage(currentPageIndex: 0)
  ));
