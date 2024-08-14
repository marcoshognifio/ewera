import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

const String url = "http://127.0.0.1:8000";

String token="";


List<String> listRoutes = [];

TextStyle textWelcome = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25,
    color: Colors.white,
    letterSpacing: 2
);

Color colorApp = const Color(0xFF115E2B);
List<Color> listColor = [const Color(0xFF74B72F), const Color(0xFF12642E)];
TextStyle textWelcomeUnder = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 17,
    letterSpacing: 2,
    color: Colors.white.withOpacity(0.7)
);


class CounterPage {
  int value;
  CounterPage(this.value);
}

List<List> groupTree =[];



   List<Map> listTree =   [
      {
        'name_one' : "Aloe Vera",
        'name_two':'Aloes',
        'image' : 'assets/plantes/wall1.jpg',
        'description': "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
        'details': [
          "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          "Vertus :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        ]
      },
     {
       'name_one' : "Contractions Spasmodiques",
       'name_two':'Diaphragme Codycross',
       'image' : 'assets/plantes/wall2.png',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Organe Femelle",
       'name_two':'fleurs-codycross',
       'image' : 'assets/plantes/wall3.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Aloe Vera",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall4.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
        'name_one' : "Organe Femelle",
        'name_two':'fleurs-codycross',
       'image' : 'assets/plantes/wall5.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Contractions Spasmodiques",
       'name_two':'Diaphragme Codycross',
       'image' : 'assets/plantes/wall6.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Aloe Vera",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall7.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Quasar Compact Codycross",
       'name_two':'Compact Codycross',
       'image' : 'assets/plantes/wall8.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Aloe Vera",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall9.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Contractions Spasmodiques",
       'name_two':'Contractions Spasmodiques',
       'image' : 'assets/plantes/wall10.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Aloe Vera",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall11.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Aloe Vera",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall12.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Contractions Spasmodiques",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall13.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Compact Codycross",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall14.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Aloe Vera",
       'name_two':'Compact Codycross',
       'image' : 'assets/plantes/wall15.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },

     {
       'name_one' : "Aloe Vera",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall16.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Contractions Spasmodiques",
       'name_two':'Diaphragme Codycross',
       'image' : 'assets/plantes/wall17.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Organe Femelle",
       'name_two':'fleurs-codycross',
       'image' : 'assets/plantes/wall18.png',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Aloe Vera",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall19.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Organe Femelle",
       'name_two':'fleurs-codycross',
       'image' : 'assets/plantes/wall20.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Contractions Spasmodiques",
       'name_two':'Diaphragme Codycross',
       'image' : 'assets/plantes/wall21.png',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Aloe Vera",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall22.png',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Quasar Compact Codycross",
       'name_two':'Compact Codycross',
       'image' : 'assets/plantes/wall23.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Aloe Vera",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall24.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Contractions Spasmodiques",
       'name_two':'Contractions Spasmodiques',
       'image' : 'assets/plantes/wall25.png',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Aloe Vera",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall26.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Aloe Vera",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall27.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Contractions Spasmodiques",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall28.png',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Compact Codycross",
       'name_two':'Aloes',
       'image' : 'assets/plantes/wall29.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },
     {
       'name_one' : "Aloe Vera",
       'name_two':'Compact Codycross',
       'image' : 'assets/plantes/wall30.jpg',
       'description' :"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
       'details':[
         "Aspect général :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Feuilles :Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
         "Vertus :It is a long established fact that a reader will be distracted by the readable content of a page when looking at its.",
         "Aspect général :Lorem Ipsum is simply dummy text of the printing and typesetting industry."
       ]
     },

    ];

class DataClass{

   Future<List> getTree() async{

    List<List> result = [];
    int n = listTree.length;
    int a = 5,b=0;
    int c = (n/a) as int;

    List E=[];
    for(int i=0;i<c;i++){
      E=[];
      for(int j =0;j<a;j++){

        E.add(Map.from(listTree[b]));
        b++;
      }
      result.add(E);
    }
    c = c*a;
    n = n-c;
    E=[];
    for(int i=0;i<n;i++){
      E.add(Map.from(listTree[b]));
      b++;
    }
    groupTree = result;
    return [];
  }

}
