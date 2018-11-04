import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Map prefsInitData = {'selectAccount': '', 'accountNames': [], 'accountsDetail': {}};

var globalPrefs;
initPreferences () async {
  SharedPreferences globalPrefs = await SharedPreferences.getInstance();
  //if (prefs.getString('walletData') != null) return prefs;
  String walletData = json.encode(prefsInitData);//map to string
  await globalPrefs.setString('walletData', walletData);
  return globalPrefs;
}