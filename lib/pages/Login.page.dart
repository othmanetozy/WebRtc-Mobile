import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testflutter/components/button.dart';
import 'package:testflutter/components/text_field.dart';


class LoginPage extends StatefulWidget {
  final void Function() onTap;

  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();

  //sign in user
  void signIn() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordController.text);
    }on FirebaseException catch(e) {
      displayMessage(e.code);
    }
  }


  void displayMessage(String messsage){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text(messsage),
    ),
    );
  }

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
              mainAxisAlignment: MainAxisAlignment.center,
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
            MyButton(
                text: 'Signin',
                onTap: signIn,),
                const SizedBox(height: 25,),
                //Register Me



                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member ? ", style: TextStyle(color: Colors.indigo)),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    )
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
