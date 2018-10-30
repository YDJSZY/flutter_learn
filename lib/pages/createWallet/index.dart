import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:dio/dio.dart';
import '../../components/toaster/index.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Dio dio = new Dio();

String accountNameValidText (String type) {
  print(type);
  if (type == 'accountUseful') {
    return '账户名可用';
  }
  if (type == 'accountUnUseful') {
    return '账户名已存在';
  }
  if (type == 'invalidateAccount') {
    return '账户名只能是a~z数字1~5组合，长度12位';
  }
  return '';
}

class CreateWallet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateWalletState();
}
class CreateWalletState extends State<CreateWallet> {
  bool isAgree = false;
  bool passwordError = false;
  bool confirmPasswordError = false;
  String accountNameStatus = '';
  String accountName = '';
  String password = '';
  String confirmPassword = '';
  String accountUseful = '账户名可用';
  String accountUnUseful = '账户名已存在';
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
    if (accountName == '') return;
    final res = await dio.post('http://45.76.11.245:7001/api/v1/validAccountName', data: {'account_name': accountName});
    print(res.data);
    if (res.data['success']) {
      setState(() {
        accountNameStatus = 'accountUseful';
      });
    } else {
      setState(() {
        accountNameStatus = 'accountUnUseful';
      });
    }
  }

  accountNameOnChange (val) {
    setState(() {
      accountName = val;
      bool validateRes = validAccountName();
      if (accountName == '') {
        accountNameStatus = '';
      } else if (validateRes) {
        accountNameStatus = '';
      } else {
        accountNameStatus = 'invalidateAccount';
      }
    });
  }

  bool validAccountName () {
    RegExp exp = new RegExp(r'^[1-5a-z]{12,12}$');
    final regRes = exp.hasMatch(accountName);
    if (regRes) return true;
    if (accountName != '' && !regRes) return false;
    return false;
  }

  passwordOnChange (val) {
    setState(() {
      password = val;
      if (val != '' && val.length < 8) {
        passwordError = true;
      } else {
        passwordError = false;
      }
      validateConfirmPassword ();
    });
  }

  validateConfirmPassword () {
    var error = false;
    if (password != '' && confirmPassword != '' && password != confirmPassword) {
      error = true;
    } else {
      error = false;
    }
    setState(() {
      confirmPasswordError = error;
    });
  }

  confirmPasswordOnChange (val) {
    setState(() {
      confirmPassword = val;
      validateConfirmPassword();
    });
  }

  gotoBackup () async {
    print(111);
    await checkAccountName();
    print(666);
    if (accountNameStatus == 'accountUnUseful' || passwordError || confirmPasswordError) {
      Toaster.error(msg: '输入有误');
    }
  }

  bool createBtnDiasbled () {
    return isAgree && accountName != '' && password != '' && confirmPassword != '';
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
                    margin: EdgeInsets.only(top: 13.0),
                    height: 53.0,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                              border: InputBorder.none,
                              errorText: accountNameValidText(accountNameStatus),
                              errorStyle: TextStyle(
                                color: accountNameStatus == 'accountUseful' ? Color(0xFF06c288) : Color(0xFFF03333),
                              )
                            ),
                            autofocus: false,
                            onChanged: accountNameOnChange,
                            maxLength: 12,
                          )
                        ),
                        RaisedButton(
                          padding: EdgeInsets.only(top: 8.0, right: 13.0, bottom: 8.0, left: 13.0),
                          onPressed: validAccountName() ? checkAccountName : null,
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
                    margin: EdgeInsets.only(top: 18.0),
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
                              border: InputBorder.none,
                              errorText: passwordError ? '请输入至少8位字符，建议混合大小写字母、数字、符号' : ''
                            ),
                            autofocus: false,
                            obscureText: true,
                            onChanged: passwordOnChange,
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
                    margin: EdgeInsets.only(top: 18.0),
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
                              border: InputBorder.none,
                              errorText: confirmPasswordError ? '密码不一致' : ''
                            ),
                            autofocus: false,
                            obscureText: true,
                            onChanged: confirmPasswordOnChange,
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
                    margin: EdgeInsets.only(top: 10.0),
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
                          onPressed: createBtnDiasbled() ? gotoBackup : null,
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
                  ),
                  Stack(
                    children: <Widget>[
                      SpinKitFadingCircle(
                        color: Color(0xFF3B3B43)
                      ),
                    ],
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