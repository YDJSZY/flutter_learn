import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../components/toaster/index.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../redux/actions.dart';

Dio dio = new Dio();

String privateKeyTip = '请备份私钥并妥善保管，不要发给任何人（包括您的朋友），您的朋友帮你完成账户创建后，您需要通过此私钥导入EOS账户。';

class BackupKeys extends StatelessWidget {
  var keys;//私钥和公钥
  var password;//密码
  String accountName;//eos账户名称
  BackupKeys(this.keys, this.accountName, this.password);

  createWallet (store) async {
    final res = await dio.post('http://192.168.1.2:7001/api/v1/createEosAccount', 
      data: {'account': accountName, 'publicKey': keys['publicKey'], 'privateKey': keys['privateKey']}
    );
    if (res.data['success']) {
      var secretData = await createSecretData();
      store.dispatch({'type': Actions.SetSharePresString, 'key': 'secretData', 'data': secretData});
      Toaster.success(msg: '创建成功');
    } else {
      Toaster.error(msg: '创建失败');
    }
  }

  createSecretData () async {//加密数据
    final res = await dio.post('http://192.168.1.2:7001/api/v1/encryptData', 
      data: {'password': password, 'data': keys['privateKey']}
    );
    if (res.data['success']) {
      return res.data['data'];
    }
  }

  @override
  Widget build(BuildContext context) {
    print(accountName);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text('备份私钥'),
        centerTitle: true,//标题居中
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(16.0, 44.0, 16.0, 0.0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 44.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        '公钥',
                        style: TextStyle(
                          color: Color(0xFF3B3B43),
                          fontSize: 18.0
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Color(0xFFEEEEEE)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text.rich(
                            TextSpan(
                              text: keys['publicKey'].toString(),
                              style: TextStyle(
                                color: Color(0xFF3B3B46),
                                fontSize: 14.0
                              ),
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: '复制',
                              style: TextStyle(
                                color: Color(0xFF3B3B46),
                                fontSize: 15.0
                              ),
                            ),
                            //textAlign: TextAlign.end,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 44.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        '私钥',
                        style: TextStyle(
                          color: Color(0xFF3B3B43),
                          fontSize: 18.0
                        ),
                      ),
                    ),
                    Text(
                      privateKeyTip,
                      style: TextStyle(
                        color: Color(0xFF3B3B43),
                        fontSize: 14.0
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Color(0xFFEEEEEE)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text.rich(
                            TextSpan(
                              text: keys['privateKey'].toString(),
                              style: TextStyle(
                                color: Color(0xFF3B3B46),
                                fontSize: 14.0
                              ),
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: '复制',
                              style: TextStyle(
                                color: Color(0xFF3B3B46),
                                fontSize: 15.0
                              ),
                            ),
                            //textAlign: TextAlign.end,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 65.0, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    new StoreConnector<dynamic, String>(
                    converter: (store) {
                      var sharePres = store.state.sharePres;
                      print('sharePres');
                      var secretData = sharePres.sharePres.getString('secretData');
                      print(sharePres);
                      return secretData;
                    }, 
                    builder: (context, secretData) {
                      print('出事');
                      print(secretData);
                      return Text(
                        secretData
                      );
                    }),
                    new StoreConnector<dynamic, VoidCallback>(
                      converter: (store) {
                        return () => createWallet(store);
                      },
                      builder: (context, callback) {
                        return RaisedButton(
                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          onPressed: callback,
                          color: Color(0xFF3B3B43),
                          child: Text(
                            '私钥已备份完成',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19.0
                            )
                          ),
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                        );
                      }
                    )
                  ]
                )
              ),
            ],
          ),
        )
      )
    );
  }
}