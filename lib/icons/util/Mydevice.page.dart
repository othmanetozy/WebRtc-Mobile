import 'package:flutter/material.dart';



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
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[100],
          borderRadius : BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            //Icons
            Image.asset(
                iconDevice,height: 60,
            ),
            
            //name the device 
            Text(DeviceUsine)
          ],
        ),
      ),
    );
  }
}
