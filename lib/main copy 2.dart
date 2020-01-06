import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:html_parse/models.dart';

// Future<Post> fetchPost() async {
//   final response =
//       await http.get('http://www.nfl.com/feeds-rs/scores/2019/REG/16.json');
//   if (response.statusCode == 200) {
//     // If the call to the server was successful, parse the JSON
//     return Post.fromJson(json.decode(response.body));
//   } else {
//     // If that call was not successful, throw an error.
//     throw Exception('Failed to load post');
//   }
// }
// class Post {
//   final String gameId;

//   Post({this.gameId});
//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       gameId: json['gameScores'][0]['gameSchedule']['gameId']
//     );
//   }
// }
// void main() => runApp(MyApp(post: fetchPost()));
// class MyApp extends StatelessWidget {
//   final Future<Post> post;
//   MyApp({Key key, this.post}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Fetch Data Example'),
//         ),
//         body: Center(
//           child: FutureBuilder<Post>(
//             future: post,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//               return Text(snapshot.data.gameId);
//               } else if (snapshot.hasError) {
//                 return Text("${snapshot.error}");
//               }
//               // By default, show a loading spinner
//               return CircularProgressIndicator();
             
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

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

  class Matchup {
    final String gameId;
    final String homeNickname;
    final String visitorNickname;

    Matchup({this.gameId,this.homeNickname,this.visitorNickname });

    factory Matchup.fromJson(Map<String, dynamic> json) {
      return  Matchup(
        gameId: json['gameId'],
        homeNickname: json['homeNickname']as String,
        visitorNickname: json['visitorNickname'] as String  
      );
  }
}

class _MyHomePageState extends State<MyHomePage> {

   List<Matchup> _games = List<Matchup>();


// json fetch function
Future<List<Matchup>> getGames() async {
    var url = 'http://www.nfl.com/feeds-rs/scores/2019/REG/16.json';
    var data = await http.get(url);

    var games = List<Matchup>();
    
    if (data.statusCode == 200) {
    var gameData = json.decode(data.body);  

      for (var game in gameData) {
        games.add(Matchup.fromJson(game));
      }
    }

    return games;
     
      

  }
// override the init state 
@override
  void initState() {
    getGames().then((value) {
      setState(() {
        _games.addAll(value);
        print(_games);

      });
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

 
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(widget.title),
    //   ),
    //   body: new Container(),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       print('test');
    //       print(http.Response);
    //     },
    //     tooltip: 'Load me up!',
    //     child: Icon(Icons.view_list),
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter listview with json'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _games[0].gameId,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    _games[0].gameId,
                    style: TextStyle(
                      color: Colors.grey.shade600
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: _games.length,
      ),
             floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('test');
          print(http.Response);
           print(Matchup);
        },
        tooltip: 'Load me up!',
        child: Icon(Icons.view_list),
      )//
    );
   
  }


}