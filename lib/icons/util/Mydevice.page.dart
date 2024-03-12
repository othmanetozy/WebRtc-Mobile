import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class Mydevice extends StatelessWidget {
  final String DeviceUsine;
  final String iconDevice;
  final bool powerOn;

  const Mydevice({
    Key? key,
    required this.DeviceUsine,
    required this.iconDevice,
    required this.powerOn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[100],
          borderRadius : BorderRadius.circular(10),
        ),
        //padding: EdgeInsets.symmetric(vertical: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Icons
            Image.asset(
                iconDevice,height: 60,
            ),
            
            //name the device 


            Row(
              children: [
                  Expanded(child: Text(DeviceUsine)),
                  CupertinoSwitch
                  (value: false,
                    onChanged: (value) {}
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
