import 'actions.dart';
import 'state.dart';

AppState mainReducer(AppState state, dynamic action){

  if (action['type'] == Actions.SetMyInfo) {
    state.myInfo.infos = action['data'];
  }

  if (action is TransactionRecord) {
    state.transactionRecord.order = action.order;
  }

  if (Actions.SetCount == action) {
    state.transactionRecord.count += 1;
  }

  return state;
}