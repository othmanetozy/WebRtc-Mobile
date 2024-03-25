import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Test> {
  late final IO.Socket socket;
  final _locally = RTCVideoRenderer();
  final _remote = RTCVideoRenderer();
  MediaStream? localStream;
  RTCPeerConnection? pc;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await _locally.initialize();
    await _remote.initialize();

    await connectSocket();
    await joinRoom();
  }

  Future<void> connectSocket() async {
    socket = IO.io("http://localhost:3001",
        IO.OptionBuilder().setTransports(['websocket']).build());
    socket.onConnect((data) => print("data connected"));

    socket.on("joined", (data) {
      _sendOffer();
    });

    socket.on("offer", (data) async {
      data = jsonDecode(data);
      await _gotOffer(RTCSessionDescription(data['sdp'], data['type']));
      await _sendAnswer();
    });

    socket.on("answer", (data) {
      data = jsonDecode(data);
      _gotAnswer(RTCSessionDescription(data['sdp'], data['type']));
    });

    socket.on("ICE", (data) {
      data = jsonDecode(data);
      _gotICE(RTCIceCandidate(
          data['condidat'], data['sdpMip'], data['sdpMlineIndex']));
    });
  }

  Future<void> joinRoom() async {
    final config = {
      "IceServer": [
        {"url": "stun:stun1.l.google.com:19302"},
        {"url": "stun:stun4.l.google.com:19302"},
      ]
    };

    final sdpConstraint = {
      "mandatory": {
        'offreToReciveAudio': true,
        'offreToReciveVideo': true,
      },
      'optional': []
    };

    pc = await createPeerConnection(config, sdpConstraint);

    final mediaConstraints = {
      'audio': true,
      'video': {'facingMode': 'user'}
    };

    try {
      localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      _locally.srcObject = localStream;
    } catch (e) {
      print('Error accessing camera: $e');
      return;
    }

    localStream!.getTracks().forEach((track) {
      pc!.addTrack(track, localStream!);
    });

    pc!.onIceCandidate = (ice) {
      // ICE
      _sendICE(ice);
    };

    pc!.onAddStream = (stream) {
      _remote.srcObject = stream;
    };

    socket.emit('join');
  }

  Future<void> _sendOffer() async {
    print("Send me offer");
    //RTCSessionDescription
    var offer = await pc!.createOffer();
    pc!.setLocalDescription(offer);
    socket.emit('offer', jsonEncode(offer.toMap()));
  }

  Future<void> _gotOffer(RTCSessionDescription offer) async {
    pc!.setRemoteDescription(offer);
  }

  Future<void> _sendAnswer() async {
    var answer = await pc!.createAnswer();
    pc!.setLocalDescription(answer);
    socket.emit('answer', jsonEncode(answer.toMap()));
  }

  Future<void> _gotAnswer(RTCSessionDescription answer) async {
    pc!.setRemoteDescription(answer);
  }

  Future<void> _gotICE(RTCIceCandidate ice) async {
    pc!.addCandidate(ice);
  }

  Future<void> _sendICE(RTCIceCandidate ice) async {
    socket.emit('ice', jsonEncode(ice.toMap()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Row(
        children: [
          Expanded(child: RTCVideoView(_locally)),
          Expanded(child: RTCVideoView(_remote)),
        ],
      ),
    );
  }
}
