import 'package:flutter/material.dart';
import 'package:testflutter/icons/util/Mydevice.page.dart';

class HomePage extends StatelessWidget {

  final double horizantalPading = 40;
  final double verticalPading = 25;

  // list

  List myDevices = [
    ["usine 1 ","lib/icons/img1.jpg",true],
    ["usine 2 ","lib/icons/img2.jpg",false],
    ["usine 3 ","lib/icons/img3.jpg",false],
    ["usine 4 ","lib/icons/img4.jpg",false],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: const Text("BL Remote Assist")),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:horizantalPading,
                  vertical: verticalPading,
              ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bienvenue", style: TextStyle(color: Colors.black)),
                  Text("Berger-Levrault",style: TextStyle(fontSize: 40,color: Colors.red),)
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:horizantalPading),
              child: Text("Industry GMAO")
            ),
            Expanded(
              child: GridView.builder(
                itemCount: myDevices.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2
                ),
                itemBuilder: (context, index) {
                  // Here you should return the widget for each item in the grid
                  return Mydevice(
                      DeviceUsine: myDevices[index][0],
                      iconDevice: myDevices[index][1],
                      powerOn: myDevices[index][2]
                  );
                },
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
              },
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
              },
              title: Text(
                "Consulting",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: "Rubik-Italic",),
              ),
            ),
            ListTile(
              leading: Icon(Icons.production_quantity_limits, color: Theme.of(context).primaryColor,),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
              onTap: (){
                Navigator.pushNamed(context, "/products");
              },
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
