import 'package:flutter/material.dart';
import 'package:testflutter/components/text_field.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Column(
              children: [
                //logo
                const SizedBox(height: 50,),
               Icon(Icons.lock,
               size: 120,
                 color: Colors.black,
               ),
                const SizedBox(height: 40,),
                Text("Welcome back",style:TextStyle(fontSize: 20,)),
                const SizedBox(height: 25,),



                //email
                MyTextField(controller: emailTextController, hintText: 'email', obscureText: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
