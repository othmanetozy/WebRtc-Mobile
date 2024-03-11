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
    return Container(
      decoration: BoxDecoration(color: Colors.grey[400]),
      child: Column(
        children: [
          //Icons
          Image.asset(
              iconDevice,height: 40,
          ),
        ],
      ),
    );
  }
}
