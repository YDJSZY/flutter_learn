import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:dio/dio.dart';
Dio dio = new Dio();

class CreateWallet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateWalletState();
}
class CreateWalletState extends State<CreateWallet> {
  bool isAgree = false;
  String accountName = '';
  final TapGestureRecognizer agreeProtocolTap = new TapGestureRecognizer();
  @override
  void initState() {
    super.initState();
  }

  switchCheck (bool checked) {
    setState(() {
      isAgree = checked;
    });
  }

  checkAccountName () async {
    final res = await dio.post('http://45.76.11.245:7001/api/v1/validAccountName', data: {'account_name': accountName});
    print(res);
  }

  accountNameOnChange (e) {
    setState(() {
      accountName = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    agreeProtocolTap.onTap = () {
      setState(() {
        isAgree = !isAgree;
      });
    };

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text('创建钱包'),
        centerTitle: true,//标题居中
      ),
      body: SingleChildScrollView(
        child: Container(
        color: Color(0xFFFFFFFF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Color(0xFFEEEEEE),
              padding: EdgeInsets.fromLTRB(18.0, 13.0, 18.0, 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '* 密码用于保护私钥和交易授权，强度非常重要',
                    style: TextStyle(
                      color: Color(0xFFA0A0A0),
                      fontSize: 13.0
                    ),
                  ),
                  Text(
                    '* PUTLINK不存储密码，也无法帮助您找回，请务必牢记',
                    style: TextStyle(
                      color: Color(0xFFA0A0A0),
                      fontSize: 13.0
                    ),
                  )
                ]
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 53.0,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black
                            ),
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 13.0),
                              labelText: "钱包名称",
                              border: InputBorder.none
                            ),
                            autofocus: false,
                            onChanged: accountNameOnChange,
                          )
                        ),
                        RaisedButton(
                          padding: EdgeInsets.only(top: 8.0, right: 13.0, bottom: 8.0, left: 13.0),
                          onPressed: checkAccountName,
                          color: Color(0xFF3B3B43),
                          child: Text(
                            '检测账户名',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0
                            )
                          ),
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                        ), 
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFDFDFDF),
                          width: 1.0,//border 粗度
                        )
                      )
                    )
                  ),
                  Container(
                    height: 53.0,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black
                            ),
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 13.0),
                              labelText: "钱包密码",
                              border: InputBorder.none
                            ),
                            autofocus: false,
                            obscureText: true,
                          )
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFDFDFDF),
                          width: 1.0,//border 粗度
                        )
                      )
                    )
                  ),
                  Container(
                    height: 53.0,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black
                            ),
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 13.0),
                              labelText: "确认密码",
                              border: InputBorder.none
                            ),
                            autofocus: false,
                            obscureText: true,
                          )
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFDFDFDF),
                          width: 1.0,//border 粗度
                        )
                      )
                    )
                  ),
                  Container(
                    child: Row(  
                      mainAxisAlignment: MainAxisAlignment.start,
                      textDirection: TextDirection.ltr,
                      children: [
                        Checkbox(
                          value: isAgree,
                          onChanged: switchCheck,
                          activeColor: Colors.black,
                        ),
                        Expanded(
                          child: Text.rich(
                            TextSpan(//处理不同的文本时可以用这个组件
                              text: '我已经仔细阅读并同意 ',
                              style: TextStyle(
                                color: Color(0xFFBEBEBF)
                              ),
                              recognizer: agreeProtocolTap,
                              children: [
                                TextSpan(
                                  text: '  泰链钱包服务及隐私协议',
                                  style: TextStyle(
                                    color: Color(0xFF1890FF)
                                  ),
                                  //recognizer: openAgreementTap
                                )
                              ]
                            )
                          ),
                        ),                        
                      ]
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 65.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/create-wallet');//跳转到创建钱包
                          },
                          color: Color(0xFF3B3B43),
                          child: Text(
                            '创建钱包',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19.0
                            )
                          ),
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                        ),
                      ]
                    )
                  )
                ]
              )
            )
          ],
        )
      ),
      )
    );
  }
}