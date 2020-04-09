import 'package:flutter/material.dart';
import 'package:indefiniteprogressindicator/indefinite_progress_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IndefiniteProgressIndicator(
              activeColor: Colors.red,
              radius: 45,
            ),
            IndefiniteProgressIndicator(
              activeColor: Colors.blue,
              radius: 25,
            ),
            IndefiniteProgressIndicator(
              activeColor: Colors.greenAccent,
              radius: 125,
            ),
          ],
        ),
      ),
    );
  }
}
