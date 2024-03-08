import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  final double horizantalPading = 40;
  final double verticalPading = 25;



  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.grey[300],
      appBar: AppBar(title: const Text("BL Remote Assist")),
      /*body: Center(
        child: Text(
          "Bienvenue",
          style: TextStyle(color: Colors.red, fontSize: 30),
        ),
      ),*/
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'lib/icons/menu.png',
                    height: 45,
                    color: Colors.grey[800],
                  ),
                  Icon(
                    Icons.person,
                    size: 45,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Text("Hello Everyone"),
                  Text("Berger-Levrault")
                ],
              ),
            )
          ],
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
              leading: Icon(
                Icons.home, color: Theme.of(context).primaryColor,),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
              onTap: (){
                Navigator.pushNamed(context, "/");
              },   // click
              title: Text(
                "Home",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: "Rubik-Italic",),
              ),
            ),
            ListTile(// list item
              leading: Icon(
                Icons.stars, color: Theme.of(context).primaryColor,),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
              onTap: (){
                Navigator.pushNamed(context, "/review");
              },  // click
              title: Text(
                "Review",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: "Rubik-Italic",),
              ),
            ),
            ListTile(// list item
              leading: Icon(
                Icons.supervised_user_circle, color: Theme.of(context).primaryColor,),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
              onTap: (){
                Navigator.pushNamed(context, "/consulting");
              },   // click
              title: Text(
                "Consulting",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: "Rubik-Italic",),
              ),
            ),
            ListTile(// list item
              leading: Icon(
                Icons.production_quantity_limits, color: Theme.of(context).primaryColor,),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
              onTap: (){
                Navigator.pushNamed(context, "/products");
              },   // click
              title: Text(
                "Products",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: "Rubik-Italic",),
              ),
            ),
          ],
        ),
      ),
    );
  }
}