import 'package:flutter/material.dart';
import 'package:testflutter/components/button.dart';
import 'package:testflutter/components/text_field.dart';
import 'package:testflutter/pages/home.page.dart';

class register extends StatefulWidget {

  final Function()? onTap;
  const register({super.key, required this.onTap});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {

  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
                  Text("Create Your Account",style:TextStyle(fontSize: 20,)),
                  const SizedBox(height: 25,),

                  //Email
                  MyTextField(controller: emailTextController, hintText: 'Email', obscureText: false),
                  const SizedBox(height: 10,),

                  //Password

                  MyTextField(controller: passwordController, hintText: 'Password', obscureText: true),
                  const SizedBox(height: 10,),

                  //Confirm Password

                  MyTextField(controller: confirmPasswordController, hintText: 'Confirm Password', obscureText: true),
                  const SizedBox(height: 10,),


                  //buttom
                  MyButton(onTap: () {
                  }, text: 'Sign Up'
                  ),
                  const SizedBox(height: 25,),

                  //Register Me

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have account " ,style:TextStyle(color: Colors.indigo) ,),
                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: widget.onTap,
                        child:  Text("Login Here",style: TextStyle(
                          fontWeight: FontWeight.bold,color: Colors.red,
                        ),),
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
