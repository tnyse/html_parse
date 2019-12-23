import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' show parse;
// import 'package:html/dom.dart';




void main() => runApp(MyApp());


// // fetch html
// Future<String> fetchHTML(String url) async {
//   final response = await http.get('http://www.tonyminter.com');
Future<http.Response> _getData() async {
    String url = 'http://www.nfl.com/ajax/scorestrip?season=2019&seasonType=REG&week=17';
    return await http.get(url);
  

  // if (response.statusCode == null)
  //   return response.body;
  // else throw Exception('Failed');
  
}

  // FutureBuilder<String>(
  //     future: fetchHTML('http://your_page.ru/page.html'),
  //     builder: (context, snapshot){
  //       if (snapshot.hasData) {
  //         //Your downloaded page
  //         _temp = snapshot.data;
  //         print(snapshot.data);
  //         return Text('Finished');
  //       }
  //       else if (snapshot.hasError)
  //         return Text('ERROR');

  //       return Text('LOADING');
  //     },
  //   ),

   // parse(_temp);



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter HTML Parsing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter HTML parse'),
      
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


 runtheJewels() {
    debugPrint('button works');
    print('this too');
  }

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
            Text(
              'can you get the html in?',
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print('test');
          runtheJewels();
          _getData().then((response){
              //dom.Document document = parser.parse(response.body);
              debugPrint(response.body);
            }).catchError((e) => print(e));
        },
        tooltip: 'Load me up!',
        child: Icon(Icons.view_list),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
