import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dataview.dart';
import 'graph.dart';
import 'login.dart';


Future<void> main() async {
  // Dart에서는 비동기 작업 수행하기 위해 Future클래스와 async 및 await 키워드 사용
  WidgetsFlutterBinding.ensureInitialized(); // framework를 Flutter engine에 결합
  await Firebase.initializeApp(); // firebae 초기화
  runApp(MyApp()); //앱 실행
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Weight',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0x00000ff0)),
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("image/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        //child:Container(color: Colors.blue,)
        child: LoginPage(), //나중에는 LoginPage()로 수정하고 login.dart 수정하기
        //child: GraphPage(), //차트 페이지
        //child: DataViewPage(),
      ),
    );
  }
}