import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:html_parse/test.dart';
// import 'package:html_parse/game.dart';
// import 'package:html_parse/game.dart';
// import 'package:xml2json/xml2json.dart';

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
      home: MyHomePage(title: 'Flutter Json parse'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//
class _MyHomePageState extends State<MyHomePage> {
  MyHomePage({Key key, this.title}) : super(key: key);
//////////////  test the button
  runtheJewels() {
    debugPrint('button works');
  



  }

final String url = 'https://nfl.com/liveupdate/scorestrip/ss.json';
//final String url = 'https://www.nfl.com/ajax/scorestrip?season=2018&seasonType=REG&week=7';

static Future<String> get({url : String, parameters : Map, headers: Map }) async {
  var client = new http.Client();
  final response = await client.get(url);
  print(response.body);
  var resultJSON  = {
      'status' : response.statusCode,
      'body' : json.decode(response.body)
  };
  return resultJSON.toString();

  
}

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          // slivar bar
          const SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('NFL Schedule Week: 1'),
            ),
          ),

          //
          SliverFixedExtentList(
            itemExtent: 200.0,
            delegate: SliverChildBuilderDelegate(
              (
                BuildContext context,
                i,
              ) {
                return new Column(
                  children: <Widget>[
                    new Text(
                        // "INFO FROM JSON: ${gameData[i]} "),
                        "INFO FROM JSON:  "),
                    const Divider(
                      color: Colors.blueGrey,
                      height: 10.0,
                    ),
                  ],
                );
              },
            // childCount: gameData == null ? 0 : gameData.length,
            childCount: 15,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('test');
          runtheJewels();
          print(jsonDecode(url).body);
        },
        tooltip: 'Load me up!',
        child: Icon(Icons.view_list),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
