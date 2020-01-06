
 class Game {


    final List<Game> game;
    
    Game({this.game });

    factory Game.fromJson(Map<String, dynamic> parsedJson) {
      return  Game(
        game: parsedJson['eid'] ,

      );
  }


  }


  class  Week {
    final int week;
    final List<Game> games;

    Week({this.week,this.games});
    factory Week.fromJson(Map<String, dynamic> json){
     return Week(
      week: json['w'],
     // games: parsedGames(json['eid']),
    );     
    }

  static List<dynamic> parsedGames(gamesJson) {
    List<dynamic> gamesList = new List<dynamic>.from(gamesJson);
    return gamesList;
  }

    
  }