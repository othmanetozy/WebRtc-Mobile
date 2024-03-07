import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(testApp());
}

class testApp extends StatelessWidget {
  const testApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: const HomePage(), //ather page affichage home page default
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
        (title: const Text("BL Remote Assist")
    ),

      body: Center(
      child: Text("Hello" , style:TextStyle(color: Colors.red,fontSize: 30) ,),
    ),

    drawer: Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Row(),
              decoration:BoxDecoration(
                  gradient: LinearGradient(colors: [Theme.of(context).primaryColor,Colors.red])
              ) ,
            ),
        ],
      ),
    ),





    );

  }
}
