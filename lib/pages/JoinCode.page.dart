import 'package:flutter/material.dart';

class JoinCode extends StatelessWidget {
  const JoinCode ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Column(
           children: [
             Icon(Icons.arrow_back_ios_new_sharp,size: 35,)
           ],
         )
       ),
    ) ;
  }
}
