import 'package:flutter/material.dart';
import 'package:irctc_new/home.dart';
void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (Context) => homepg(),
    },
  ),);


}