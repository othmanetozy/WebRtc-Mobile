import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Test> {
  late final IO.Socket socket;
  final _Localement = RTCVideoRenderer();
  final _Remote = RTCVideoRenderer();
  MediaStream? LocalStream;
  RTCPeerConnection? pc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future init() async {}

  Future connectSocket() async {
    socket = IO.io("http://localhost:3000",
        IO.OptionBuilder().setTransports(['websocket']).build());
    socket.onConnect((data) => print("data connected"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Row(
      children: [
        Expanded(child: RTCVideoView(_Localement)),
        Expanded(child: RTCVideoView(_Remote)),
      ],
    ));
  }
}
