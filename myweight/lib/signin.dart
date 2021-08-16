import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myweight/login.dart';

class ReturnUserData {
  String userName;
  double height;
  double goalWeight;
  String macAddress;

  ReturnUserData(String a, double b, double c, String d) {
    this.userName = a;
    this.height = b;
    this.goalWeight = c;
    this.macAddress = d;
  }

  ReturnUserData.setUserName(String str) {
    this.userName = str;
  }
}

ReturnUserData user = new ReturnUserData('rrr', 160.0, 45.0, "ffff");

class SigninPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _signin();
  }
}

class _signin extends State<SigninPage> {
  submit() {
    print(user.userName +
        " " +
        user.height.toString() +
        " " +
        user.goalWeight.toString() +
        " " +
        user.macAddress.toString() +
        " ");
    Timer(Duration(seconds: 1), () {
      Navigator.pop(context, user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("image/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          //만약 바탕을 터치하면 포커스 제거하기 (키보드 내려가도록)
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // header
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20),
                  Container(
                    width: 50,
                    child: InkWell(
                      child: Image.asset('image/back.png'),
                      onTap: () {
                        googleSignIn.signOut();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 100),
                  Text(
                    '회원 등록',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),

              // user name
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('이름 입력'),
                    Container(
                        padding: EdgeInsets.all(10),
                        width: 300,
                        height: 50,
                        child: Form(
                            child: TextFormField(
                          onChanged: (val) {
                            //텍스트폼필드에 변화가 있을 때마다
                            setState(() {
                              user.userName = val;
                            });
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.greenAccent, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                          validator: (val) {
                            if (val.trim().length < 5 || val.isEmpty) {
                              return 'user name is too short (< 5)';
                            } else if (val.trim().length > 15 || val.isEmpty) {
                              return 'user name is too long (> 15)';
                            } else {
                              return null;
                            }
                          },
                          // onSaved: (val) => input = val,
                        ))),
                  ],
                ),
              ),

              // hight
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('키 입력'),
                    Container(
                        padding: EdgeInsets.all(10),
                        width: 300,
                        height: 50,
                        child: Form(
                            child: TextFormField(
                          onChanged: (val) {
                            //텍스트폼필드에 변화가 있을 때마다
                            setState(() {
                              user.height = double.parse('$val'); //검색텍스트 갱신
                            });
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.greenAccent, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                          validator: (val) {
                            if (val.trim().length < 5 || val.isEmpty) {
                              return 'user name is too short (< 5)';
                            } else if (val.trim().length > 15 || val.isEmpty) {
                              return 'user name is too long (> 15)';
                            } else {
                              return null;
                            }
                          },
                          // onSaved: (val) => input = val,
                        ))),
                  ],
                ),
              ),

              // goal weight
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('목표 체중 입력'),
                    Container(
                        padding: EdgeInsets.all(10),
                        width: 300,
                        height: 50,
                        child: Form(
                            child: TextFormField(
                          onChanged: (val) {
                            //텍스트폼필드에 변화가 있을 때마다
                            setState(() {
                              user.goalWeight = double.parse('$val'); //검색텍스트 갱신
                            });
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.greenAccent, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                          validator: (val) {
                            if (val.trim().length < 5 || val.isEmpty) {
                              return 'user name is too short (< 5)';
                            } else if (val.trim().length > 15 || val.isEmpty) {
                              return 'user name is too long (> 15)';
                            } else {
                              return null;
                            }
                          },
                          // onSaved: (val) => input = val,
                        ))),
                  ],
                ),
              ),

              // mac address
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('MAC 주소 입력'),
                    Container(
                        padding: EdgeInsets.all(10),
                        width: 300,
                        height: 50,
                        child: Form(
                            child: TextFormField(
                          onChanged: (val) {
                            //텍스트폼필드에 변화가 있을 때마다
                            setState(() {
                              user.macAddress = val; //검색텍스트 갱신
                            });
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.greenAccent, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                          validator: (val) {
                            if (val.trim().length < 5 || val.isEmpty) {
                              return 'user name is too short (< 5)';
                            } else if (val.trim().length > 15 || val.isEmpty) {
                              return 'user name is too long (> 15)';
                            } else {
                              return null;
                            }
                          },
                          // onSaved: (val) => input = val,
                        ))),
                  ],
                ),
              ),

              // Sign up Button
              Container(
                width: 271,
                padding: EdgeInsets.only(top: 48, bottom: 110),
                child: InkWell(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Image.asset(
                          'image/signin_bar.png',
                          width: 271,
                          height: 55,
                        ),
                      ),
                      Center(
                        heightFactor: 2.7,
                        child: Text(
                          '등록하기',
                          style:
                              TextStyle(fontSize: 15, color: Color(0xff4f4b49)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  onTap: submit,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
