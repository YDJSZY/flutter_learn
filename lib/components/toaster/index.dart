import 'package:fluttertoast/fluttertoast.dart';

Map position = {
  'top': ToastGravity.TOP,
  'center': ToastGravity.CENTER,
  'bottom': ToastGravity.BOTTOM
};

class Toaster {
  static error ({String msg, String posotion = 'center'}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: position[posotion],
      //timeInSecForIos: 1,
      bgcolor: "#e74c3c",
      textcolor: '#ffffff'
    );
  }
}