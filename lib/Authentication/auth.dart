import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testflutter/pages/Login.page.dart';
import 'package:testflutter/pages/home.page.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot) {
          //user is saved on DB
          if(snapshot.hasData)
            {
              return HomePage();
            }// !=
          else{
            return LoginPage(onTap: () {});
          }
        },
      ),
    );
  }
}
