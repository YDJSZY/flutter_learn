import 'package:fluttertoast/fluttertoast.dart';

Map position = {
  'top': ToastGravity.TOP,
  'center': ToastGravity.CENTER,
  'bottom': ToastGravity.BOTTOM
};

class Toaster {
  static show ({String msg, String posotion = 'center', String bgcolor}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: position[posotion],
      //timeInSecForIos: 1,
      bgcolor: bgcolor,
      textcolor: '#ffffff'
    );
  }

  static success ({String msg, String posotion = 'center'}) {
    show(msg: msg, posotion: posotion, bgcolor: "#33B052");
  }

  static error ({String msg, String posotion = 'center'}) {
    show(msg: msg, posotion: posotion, bgcolor: "#e74c3c");
  }
}