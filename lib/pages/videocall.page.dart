import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideocallPage extends StatelessWidget {
  const VideocallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Conference"),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey[50],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text("New Meeting",
                style: TextStyle(fontSize:20),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Divider(thickness: 1,height: 40, indent: 40,endIndent: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.margin),
              label: Text("Join with a code",
              style: TextStyle(fontSize:20),
              ),
              style: OutlinedButton.styleFrom(
                fixedSize: Size(350, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
         SizedBox(height: 100),
         Image.asset(
         "lib/icons/VC.png",
            ),
        ],
      ),
    );
  }
}
