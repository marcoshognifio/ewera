import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;


const String url = "http://192.168.100.210:5000";
String token = "";
String accessToken = "";
String refreshToken = "";
Map currentUser = {};
double screenWidth = 0;
double screenHeight = 0;
NumberFormat formatter = NumberFormat.decimalPatternDigits(
  locale: 'fr',
  decimalDigits: 0,
);
Map userCurrent = {};
List<String> listRoutes = [];

TextStyle textWelcome = const TextStyle(
    fontFamily: 'Roboto-Regular',
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.white,
);

TextStyle textLogin = const TextStyle(
  fontFamily: 'Roboto-Regular',
  color: Colors.white,
  fontSize: 30,
  wordSpacing: 5,
  fontWeight: FontWeight.bold,
);

Color colorApp = const Color(0xFF115E2B);

List<Color> listColor = [const Color(0xFF74B72F), const Color(0xFF12642E)];

TextStyle textWelcomeUnder = TextStyle(
    fontFamily: 'Roboto-Regular',
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Colors.white.withOpacity(0.7)
);

String languageIndex = 'fr';

Map<String,Map> languageData = {
  'fr':{
    'passwordText': 'Mot de Passe',
    'passwordForgetText': 'Mot de Passe Oublié',
    'usernameText': 'Nom Utilisateur',
    'passwordConfirmText': 'Confirmer Mot de Passe',
    'connexionText': 'Connection',
    'inscriptionText': 'Inscription',
    'plantText': 'Plantes',
    'tisaneText': 'Tisanes',
    'astuceText': 'Astuces',
    'searchPlantText': 'Rechercher une Plante',
    'searchTisaneText': 'Rechercher une Tisane',
    'searchAstuceText': 'Rechercher une maladie',
  },

  'en':{
    'passwordText': 'Password',
    'passwordForgetText': 'Password Forget',
    'usernameText': 'Username',
    'passwordConfirmText': 'Confirm Password',
    'connexionText': 'Connexion',
    'inscriptionText': 'Inscription',
    'plantText': 'Trees',
    'tisaneText': 'Products',
    'astuceText': 'Astuces',
    'searchPlantText': 'Search a Tree',
    'searchTisaneText': 'Search a Product',
    'searchAstuceText': 'Search a Disease',
  }
};

List<Map> listPay = [
  {
    'name' : 'MTN Money',
    'image' :'assets/methods_pay/mp2.png',
    'detail' :  'Default payment'
  },
  {
    'name' : 'MOOV Money',
    'image' :'assets/methods_pay/mp3.png',
    'detail' :  'Not default payment'
  },
  {
    'name' : 'Celtis Cash',
    'image' :'assets/methods_pay/mp4.png',
    'detail' :  'Not default payment'
  },
  {
    'name' : 'MastersCard',
    'image' :'assets/methods_pay/mp1.png',
    'detail' :  'Not default payment'
  },
];





List<Map> listPlants = [],listAstuces = [], listTisanes = [],listRecipes = [];

 ValueNotifier<bool> listPlantsNotifier = ValueNotifier(false),
    listAstucesNotifier = ValueNotifier(false),
    listTisanesNotifier = ValueNotifier(false);


class CounterPage{
  late int value;
  CounterPage(this.value);
}

class DatabaseHelper {
  final databaseName = 'database.db';
  Database? _database;

  Future get database async {
    if (_database != null) {
      return _database;
    }
    else {
      _database = await initDB();
      return _database;
    }
  }

  Future<Database> initDB() async {
    print('---------INITIALISATION DB-----------');

    final directory = await getDatabasesPath();;
    final path = join(directory, databaseName);
    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
    print('---------CREATE DB-----------');

    await db.execute('''CREATE TABLE IF NOT EXISTS user(
      accessToken TEXT NOT NULL,
      refreshToken TEXT NOT NULL
      )'''
    );

    print('Batabase is create of success');
  }


  Future insertToken(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert("user", user);

    print('add project success');
  }

  Future<List<Map>> getTokenUser() async {
    final db = await database;
    return await db!.query('user');
  }

  Future<List<Map>> getPlantsAll() async {
    final uri = Uri.parse("$url/plants/all");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    listPlants = json.decode(response.body).cast<Map<dynamic, dynamic>>();
    listPlantsNotifier.value = listPlantsNotifier.value == false;
    return [];
  }

  Future<List<Map>> getTisanesAll() async {
    final uri = Uri.parse("$url/products/all");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    listTisanes = json.decode(response.body).cast<Map<dynamic, dynamic>>();
    listTisanesNotifier.value = listTisanesNotifier.value == false;
    return [];
  }

  Future<List<Map>> getAstucesAll() async {
    final uri = Uri.parse("$url/diseases/all");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    listAstuces = json.decode(response.body).cast<Map<dynamic, dynamic>>();
    listAstucesNotifier.value = listAstucesNotifier.value == false;
    return [];
  }

  Future<List<Map>> searchPlants(String item) async {
    Map<String, dynamic> request = {
      'term': item
    };
    final uri = Uri.parse("$url/plants/search");
    final response = await http.post(uri,
        body: jsonEncode(request),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }
    );

    listPlants = json.decode(response.body).cast<Map<dynamic, dynamic>>();
    listPlantsNotifier.value = listPlantsNotifier.value == false;
    return [];
  }

  Future<List<Map>> searchTisanes(String item) async {
    Map<String, dynamic> request = {
      'term': item
    };
    final uri = Uri.parse("$url/products/search");
    final response = await http.post(uri,
        body: jsonEncode(request),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }
    );

    listTisanes = json.decode(response.body).cast<Map<dynamic, dynamic>>();
    listTisanesNotifier.value = listTisanesNotifier.value == false;
    return [];
  }

  Future<List<Map>> searchAstuces(String item) async {
    Map<String, dynamic> request = {
      'term': item
    };
    final uri = Uri.parse("$url/diseases/search");
    final response = await http.post(uri,
        body: jsonEncode(request),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }
    );

    listAstuces = json.decode(response.body).cast<Map<dynamic, dynamic>>();
    listAstucesNotifier.value = listAstucesNotifier.value == false;
    return [];
  }

  Future<List<Map>> getRecipesAll(int id) async {
    final uri = Uri.parse("$url/recipes/$id");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    listRecipes = json.decode(response.body).cast<Map<dynamic, dynamic>>();
    return [];
  }

  Future getUserProfile() async {
    final uri = Uri.parse("$url/user/profile");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    userCurrent = json.decode(response.body);
  }

}



class Group {

  List<List<Map>> getGroupList(List<Map> list) {

    List<List<Map>> result = [];
    int n = list.length;
    int a = 5,b=0;
    int c = n ~/ a ;
    List<Map> E = [];
    if(c>0){
      for(int i=0;i<c;i++){
        E=[];
        for(int j =0;j<a;j++){

          E.add(list[b]);
          b++;
        }
        result.add(E);
      }
    }

    c = c*a;
    n = n-c;
    E = [];
    for(int i=0;i<n;i++){
      E.add(list[b]);
      b++;
    }

    result.add(E);

    return result;
  }
}
