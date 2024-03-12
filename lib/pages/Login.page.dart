import 'package:flutter/material.dart';
import 'package:testflutter/components/button.dart';
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
        child : Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              children: [
                //logo
                const SizedBox(height: 80,),
               Icon(Icons.lock,
               size: 120,
                 color: Colors.black,
               ),
                const SizedBox(height: 40,),
                Text("Welcome back, you've been missed!",style:TextStyle(fontSize: 20,)),
                const SizedBox(height: 25,),

             //Email
              MyTextField(controller: emailTextController, hintText: 'Email', obscureText: false),
              const SizedBox(height: 10,),

             //Password

                MyTextField(controller: passwordController, hintText: 'Password', obscureText: true),
              const SizedBox(height: 10,),


            //buttom
            MyButton(onTap: () {}, text: 'Sign In'

            ),
                const SizedBox(height: 25,),

                //Register Me

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member ? " ,style:TextStyle(color: Colors.indigo) ,),
                const SizedBox(height: 10),
                Text("Register Now",style: TextStyle(
                  fontWeight: FontWeight.bold,color: Colors.red,
                ),),
              ],
            ),




              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
