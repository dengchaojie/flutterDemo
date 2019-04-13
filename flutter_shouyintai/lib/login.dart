import 'package:flutter/material.dart';
import 'Login/Register.dart';

class LoginVC extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginVCState();
  }
}

class LoginVCState extends State<LoginVC> {

  final tfName = TextEditingController();
  final tfPassword = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    tfName.dispose();
    tfPassword.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      appBar: AppBar(
//        title: Text('登录'),
//      ),
      body: ListView(
        children: <Widget>[

          Padding(padding: EdgeInsets.only(top: 40),
            child: Image.asset('assets/images/hrtLoginHeader.png'),
          ),

          Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 40),
            child: TextField(decoration: const InputDecoration(labelText: '请输入手机号'),
              controller: tfName,),
          ),

          Padding(padding: EdgeInsets.only(left: 20, right: 20),
            child: TextField(decoration: const InputDecoration(labelText: '请输入密码'),
              controller: tfPassword,),
          ),

          Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 40),
            child: RaisedButton(
              onPressed: () {
                actionLogin();
              },
              child: Text('登录'),
              color: Colors.blue,
              textColor: Colors.white,
            ),
          ),

          Padding(padding: EdgeInsets.only(left: 20, right: 20),
            child: RaisedButton(
              onPressed: () {
                actionRegister();
              },
              child: Text('注册'),
              textColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
  
  void actionLogin() {
    print('actionLogin');

  }

  void actionRegister() {
    print('actionRegister');

    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) {
          return RegisterVC();
        },
      ),
    );
  }

}