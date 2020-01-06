//  Game fromJson(String gameData) {
//     Map<String, dynamic> json = jsonDecode(gameData);
//     String time = json['t'];
//     String day = json['d'];
//     DateTime gameid = DateTime.parse(json['eid']);
//     GameInfo s = new GameInfo (day, time, gameid);
//     return s;
//   }

// game class
class Game {
  int homescore, awayscore;
  String hometeam, awayteam;

  List<GameDetail> gameDetails;

  Game({
    this.hometeam,
    this.homescore,
    this.awayteam,
    this.awayscore,

    this.gameDetails
  });
      
  factory Game.fromJson(Map<String, dynamic> json) {
    return new Game(
      hometeam: json['hnn'],
      homescore: json['hs'],
      awayteam: json['vnn'],
      awayscore: json['vs'],

      gameDetails: json['gameDetails'].map((value) => new GameDetail.fromJson(value)).toList()
    );
  }
}

// game details
class GameDetail {
  String day, date, gameid;
  int time;
  

  GameDetail({
    this.gameid,
    this.day,
    this.date,
    this.time,

  });

  factory GameDetail.fromJson(Map<String, dynamic> json) {
    return new GameDetail(
        gameid: json['city'],
        date: json['state'],
        day: json['country'],
        time: json['zipcode']);
  }
}