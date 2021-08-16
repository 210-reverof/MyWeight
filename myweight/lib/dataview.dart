import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

List<dynamic> list;

class DataViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _dataView();
  }
}

Future<void> httpConn() async {
  var url = Uri.http('192.168.0.133:4100', '/', {'q': '{http}'});
  var response = await http.get(url);
  String responseBody = utf8.decode(response.bodyBytes);

  list = jsonDecode(responseBody);
  print(list);
  print(list[0]['id']);
  print(list[0]['name']);

  return;
}

returnTile(BuildContext context, int num, List clist) {
  //print(clist.length);
  var id = clist[num]['id'];
  var date = clist[num]['date'];
  var weight = clist[num]['weight'];
  return Container(
    height: 50,
    color: Colors.deepOrange,
    child: Text("$id    $date   $weight"),
  );
}

class _dataView extends State<DataViewPage> {
  
  Future<List> _fetch1() async {
    var url = Uri.http('192.168.0.133:4100', '/', {'q': '{http}'});
    var response = await http.get(url);
    String responseBody = utf8.decode(response.bodyBytes);

    List<dynamic> connlist = jsonDecode(responseBody);
    print(connlist);
    print("length : " + connlist.length.toString());
    print(connlist[0]['id']);
    print(connlist[0]['name']);

    return connlist;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetch1(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
          if (snapshot.hasData == false) {
            return CircularProgressIndicator();
          }
          //error가 발생하게 될 경우 반환하게 되는 부분
          else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          }
          // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
          else {
            return Scaffold(
              body: Column(children: <Widget>[
                RaisedButton(
                    onPressed: () {
                      setState(() {
                        _fetch1();
                      });
                    },
                    child: Text('Reload')),
                Container(
                    width: 350,
                    height: 500,
                    child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return returnTile(context, index, snapshot.data);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: snapshot.data.length))
              ]),
            );
          }
        });
  }
}
