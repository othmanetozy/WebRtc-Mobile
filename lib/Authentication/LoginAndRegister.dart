import 'package:flutter/material.dart';
import 'package:testflutter/pages/Login.page.dart';
import 'package:testflutter/pages/register.page.dart';

class LoginAndRegister extends StatefulWidget {
  const LoginAndRegister({super.key});

  @override
  State<LoginAndRegister> createState() => _LoginAndRegisterState();
}

class _LoginAndRegisterState extends State<LoginAndRegister> {

//initial showing login page

  bool SLoginPage = true;

  void BasculePage(){
    SLoginPage =! SLoginPage;
  }

  @override
  Widget build(BuildContext context) {
      if(SLoginPage){
        return LoginPage(onTap : BasculePage);
      }else{
        return register(onTap: BasculePage,);
      }
  }
}
