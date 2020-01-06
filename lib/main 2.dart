import 'package:flutter/material.dart';
import 'package:html_parse/test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
//import 'package:html_parse/game.dart';
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


//////////////  test the button
  runtheJewels() {
    debugPrint('button works');
    
    

  }


  Future<List<Game>> _getGames() async {
    String url = 'http://www.nfl.com/feeds-rs/scores/2019/REG/16.json';
    // http.Response response = await http.get(Uri.encodeFull(url),
    //     headers: {"Accept": "application/json"});
    var data = await http.get(url);
    var gameData = json.decode(data.body);  

      List<Game>  games = [];
      for (var g in gameData) {
        Game game = Game(g["gameId"],g["homeNickname"],g["visitorNickname"],g["gameDate"],g["gameTiemEastern"],);
        games.add(game);

      }

      print(games.length);

  }

  

//////////////  end build map

  @override
  Widget build(BuildContext context) {

    _getGames();

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
          SliverList(
            
            delegate: SliverChildBuilderDelegate(
              (
                BuildContext context,
                i,
              ) {
                return new Column(
                  children: <Widget>[
                    FutureBuilder(
                      future: _getGames(),
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int gameId){
                            return ListTile(
                              title: Text(snapshot.data[0].gameId),

                            );
                          }
                        );
                      },
                    ),
                    const Divider(
                      color: Colors.blueGrey,
                      height: 10.0,
                    ),
                  ],
                );
              },
            // childCount: gameData == null ? 0 : gameData.length,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('test');
          runtheJewels();
        },
        tooltip: 'Load me up!',
        child: Icon(Icons.view_list),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
