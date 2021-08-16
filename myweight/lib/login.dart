import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'signin.dart';
import 'personalmain.dart';
import 'user.dart';

final GoogleSignIn googleSignIn = new GoogleSignIn();
// variable for firestore collection 'users'
final userReference =
    FirebaseFirestore.instance.collection('users'); // 사용자 정보 저장을 위한 ref

final DateTime timestamp = DateTime.now();
User currentUser;

resetter() async {
  userReference.doc(currentUser.id).set({
    'id': currentUser.id,
    'profileName': currentUser.profileName,
    'userName': currentUser.userName,
    'email': currentUser.email,
    'image': currentUser.image,
    'macAddress': currentUser.macAddress,
    'goalWeight': currentUser.goalWeight,
    'recentWeight': currentUser.recentWeight,
    'recentDate': currentUser.recentDate,
  });
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _login();
  }
}

loginUser() {
  googleSignIn.signIn();
}

logoutUser() {
  googleSignIn.signOut();
}

class _login extends State<LoginPage> {
  bool isSignedIn = false;
  // 페이지 컨트롤
  PageController pageController;
  int getPageIndex = 0;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
    pageController = PageController();

    // 앱 실행시 구글 사용자의 변경여부를 확인함
    googleSignIn.onCurrentUserChanged.listen((gSignInAccount) {
      controlSignIn(gSignInAccount); // 사용자가 있다면 로그인
    }, onError: (gError) {
      print("Error Message : " + gError);
    });

    googleSignIn.signInSilently();
  }

  // 로그인 상태 여부에 따라 isSignedIn flag값을 변경해줌
  controlSignIn(GoogleSignInAccount signInAccount) async {
    if (signInAccount != null) {
      await saveUserInfoToFirestore();
      setState(() {
          isSignedIn = true;
      });
    } else {
      setState(() {
        isSignedIn = false;
      });
    }
  }

  saveUserInfoToFirestore() async {
    // 현재 구글 로그인된 사용자 정보 가져오기
    final GoogleSignInAccount gCurrentUser = googleSignIn.currentUser;
    // 해당 유저의 db정보 가져오기
    DocumentSnapshot documentSnapshot =
        await userReference.doc(gCurrentUser.id).get();

    // 해당 유저의 db정보가 없다면
    if (!documentSnapshot.exists) {
      final newUser = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => SigninPage()));


      // DB에 사용자 정보 저장
      userReference.doc(gCurrentUser.id).set({
        'id': gCurrentUser.id,
        'profileName': gCurrentUser.displayName,
        'userName': newUser.userName,
        'email': gCurrentUser.email,
        'image': gCurrentUser.photoUrl,
        'macAddress': newUser.macAddress,
        'goalWeight': newUser.goalWeight,
        //'recentWeight': [null,null,null,null,null],
       // 'recentDate': [null,null,null,null,null],
        'regDate' : timestamp
      });

      // 해당 정보 다시 가져오기
      documentSnapshot = await userReference.doc(gCurrentUser.id).get();
    }

    // 현재 유저정보에 값 셋팅하기
    currentUser = User.fromDocument(documentSnapshot);
  }

  buildHomeScreen() {
    return PersonalMainPage();
  }

  buildSignInScreen() {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'image/logo.png',
                width: 270,
                height: 270,
              ),
              SizedBox(height: 93),
              Container(
                width: 271,
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
                          'Sign up with Google',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff4f4b49)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  onTap: loginUser,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      //Timestamp a = currentUser.recentDate[0];
      //print(a.toDate().month);
      print("helllllllllllllllllllooooooooooooooooooooooooo");
      return buildHomeScreen();
    } else {
      print("----------------------------------------------");
      return buildSignInScreen();
    }
  }
}
