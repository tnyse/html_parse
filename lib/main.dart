import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:html_parse/models.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Json Parsing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'make nfl json work'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  List data;

  Future loadGame() async{
    String jsonString = await rootBundle.loadString('assets/data/ss.json');
    final jsonResponse = json.decode(jsonString);


  setState(() {
      data = jsonResponse["gms"];
  });
  return "success";
  

  }

 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter listview with json'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text( 'Game: ' + data[index]['eid'].toString() ,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    Text(data[index]['hnn'] + ' at ' + data[index]['vnn'],
                      style: TextStyle(color: Colors.grey.shade600,fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: data == null ? 0 : data.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('test');
            loadGame();
          },
          tooltip: 'Load me up!',
          child: Icon(Icons.view_list),
        ) //
        );


  }
 @override
  void initState() {
    super.initState();
    this.loadGame();
  }

}
