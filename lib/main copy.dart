
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html_parse/game.dart';
import 'package:http/http.dart' as http;
// import 'package:xml2json/xml2json.dart';
import 'dart:convert';


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

// Future<List<Game>> getGamesFromJSON(BuildContext context) async {
//   String url = await loadString(_getData());
//   return raw.map ((f) => Game.fromJson(f)).toList();
// }


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  runtheJewels() {
    debugPrint('button works');
    print('this too');
    
  }

  List<Game> _games = List<Game>();

  Future <List<Game>> getGamesFromJSON(BuildContext context) async{
  var  url = "http://www.nfl.com/ajax/scorestrip?season=2019&seasonType=REG&week=16";
  var response = await http.get(url);
  var games =List<Game>();

  if (response.statusCode == 200){
    var gamesJason = json.decode(response.body);
    for (var gameJson in gamesJason){
      games.add(Game.fromJSON(gameJson));
    }

  }
}


// build map from web json
// Future<List<Game>> getGamesFromJson(BuildContext context) async {
//   String url =  'http://www.nfl.com/ajax/scorestrip?season=2019&seasonType=REG&week=16';
//   await http.get(url);
//   List<dynamic> raw = jsonDecode(url);
//   return raw.map ((f) => Game.fromJson(f)).toList();
// }


// //build map from local json files
// Future<List<Game>> getGamesFromJSON(BuildContext context) async {
//   String myUrl = await rootBundle.loadString('assets/data/ss.json');
//   if (myUrl == null) {
//     print('file is null');
//   } else
//   List<dynamic> game = jsonDecode(myUrl);
//   return game.map ((f) => Game.fromJSON(f)).toList();
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: FutureBuilder(
                future: getGamesFromJSON(context),
                builder: (context, data){
                  if(data.hasData){
                    List<Game> games = data.data;

                    return ListView.builder(
                      itemCount: games.length,
                      itemBuilder: (context,index){
                        return ListTile(
                          title: Text(games[index].gameid,style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold
                          ),),
                          subtitle: Text(games[index].time),);
                      });
                  } else {
                    return Center(child: CircularProgressIndicator(),);
                  }
                } 
              )
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('test');
          runtheJewels();
        
          // runtheJewels().then((url.response) {
          //   debugPrint(response.body, wrapWidth: 1024);
          // }).catchError((e) => print(e));
        },
        tooltip: 'Load me up!',
        child: Icon(Icons.view_list),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
