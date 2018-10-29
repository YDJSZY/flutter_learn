import 'package:flutter/material.dart';
import 'containers/home/home.dart';
import 'pages/createWallet/index.dart';

Map<String, WidgetBuilder> routes = {
  '/home': (_) => new Home(),
  '/create-wallet': (_) => new CreateWallet()
};