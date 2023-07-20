import 'package:flutter/material.dart';
import './Randomwords.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple), 
        home: RandomWords(),
        debugShowCheckedModeBanner: false,
      );
  }
}
