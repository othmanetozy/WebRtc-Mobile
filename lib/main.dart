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
      theme: ThemeData(primarySwatch: Colors.deepPurple,
        textTheme:TextTheme(
          bodyMedium: TextStyle(fontSize: 30,color: Colors.deepPurple),
          bodyLarge: TextStyle(fontSize: 50, color: Colors.red),
          bodySmall: TextStyle(fontSize: 25, color: Colors.blue,fontFamily:"Rubik-Italic"),
        ),
        iconTheme: IconThemeData(color: Colors.blueAccent,size: 50)
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
      appBar: AppBar(title: const Text("BL Remote Assist")),
      body: Center(
        child: Text(
          "Bienvenue",
          style: TextStyle(color: Colors.red, fontSize: 30),
        ),
      ),

      drawer:   Drawer(
        child: Column(
          children:[
            DrawerHeader(
              child:Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/img.png"),
                    radius: 44,
                  )
                ],
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Theme.of(context).primaryColor, Colors.red])),
            ),

            ListTile(// list item
              leading: Icon(Icons.home),
              trailing: Icon(Icons.arrow_back_ios_new),
              onTap: (){},   // click
              title: Text(
                "Home",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: "Rubik-Italic",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
