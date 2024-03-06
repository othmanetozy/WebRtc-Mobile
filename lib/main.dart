import 'package:flutter/material.dart';

void main() {
  runApp(testApp());
}

class testApp extends StatelessWidget {
  const testApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(), //ather page affichage home page default
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
        (title: Text("hello")
    ),
    body: Text("hello word"),
    );
  }
}
