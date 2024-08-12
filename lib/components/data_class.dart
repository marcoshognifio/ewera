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

