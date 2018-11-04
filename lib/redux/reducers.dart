import 'actions.dart';
import 'state.dart';

AppState mainReducer(AppState state, dynamic action){

  if (action['type'] == Actions.SetMyInfo) {
    state.myInfo.infos = action['data'];
    return state;
  }

  if (action is TransactionRecord) {
    state.transactionRecord.order = action.order;
    return state;
  }

  if (Actions.SetCount == action) {
    state.transactionRecord.count += 1;
    return state;
  }

  if (action['type'] == Actions.SetCurrentPageIndex) {
    state.currentMainPage.currentPageIndex = action['data'];
    return state;
  }

  if (action['type'] == Actions.SetSelectAccount) {
    print(action['data']);
    state.accounts.selectAccount = action['data'];
    return state;
  }

  if (action['type'] == Actions.SetSharePresString) {
    print(action['key']);
    print(action['data']);
    state.sharePres.setStringData(action['key'], action['data']);
    return state;
  }

  if (action['type'] == Actions.SetSharePresMap) {
    state.sharePres.setSharePresMap(action['key'], action['data']);
    return state;
  }

  return state;
}