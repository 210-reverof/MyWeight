import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myweight/graph.dart';
import 'login.dart';

class PersonalMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _personalMain();
  }
}

class _personalMain extends State<PersonalMainPage> {
  String name = currentUser.userName;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("image/personal_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          // control focus
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
              Text(
                "My Weight",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),

              SizedBox(height: 60),

              // first section
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(children: <Widget>[
                      Container(
                        height: 80,
                        width: 200,
                      ),
                      Text(
                        "반갑습니다 \n$name 님!",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      )
                    ]),

                    SizedBox(width: 50),

                    // 프로필 사진
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(currentUser.image)),
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ]),

              SizedBox(height: 30),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4.0,
                child: Container(
                  width: 320,
                  height: 180,
                ),
              ),

              SizedBox(height: 30),
              // first button
              InkWell(
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'image/signin_bar.png',
                        width: 260,
                        height: 50,
                      ),
                    ),
                    Center(
                      heightFactor: 2,
                      child: Text(
                        '체중추이',
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff4f4b49)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  print("hello");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GraphPage()),
                  );
                },
              ),

              SizedBox(height: 15),

              // second button
              InkWell(
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'image/signin_bar.png',
                        width: 260,
                        height: 50,
                      ),
                    ),
                    Center(
                      heightFactor: 2,
                      child: Text(
                        '마이페이지',
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff4f4b49)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  print("hello2");
                  logoutUser();
                },
              ),

              SizedBox(height: 15),

              // third button
              InkWell(
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'image/signin_bar.png',
                        width: 260,
                        height: 50,
                      ),
                    ),
                    Center(
                      heightFactor: 2,
                      child: Text(
                        '문의하기',
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff4f4b49)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  print("hello3");
                },
              ),
            ],
          )),
        ),
      ),
    );
  }
}
