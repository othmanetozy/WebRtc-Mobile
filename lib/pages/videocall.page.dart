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
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  MediaStream? localStream;
  RTCPeerConnection? pc;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    await connectSockets();
    await joinRoom();
  }

  Future<void> connectSockets() async {
    socket = IO.io("http://localhost:3000",
        IO.OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((data) => print("Data connected"));

    socket.on('join', (data) {
      _sendOffer();
    });

    socket.on('offer', (data) async {
      data = jsonDecode(data);
      await _gotOffer(RTCSessionDescription(data['sdp'], data['type']));
      await _sendAnswer();
    });

    socket.on('answer', (data) {
      data = jsonDecode(data);
      _gotAnswer(RTCSessionDescription(data['sdp'], data['type']));
    });

    socket.on("ICE", (data) {
      data = jsonDecode(data);
      _gotIce(RTCIceCandidate(
          data['condidat'], data['sdpMip'], data['sdpMlineIndex']));
    });
  }

  Future<void> joinRoom() async {
    final config = {
      'iceServers': [
        {"url": "stun:stun.l.google.com:19302"},
      ]
    };

    final sdpConstraints = {
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': true,
      },
      'optional': []
    };

    pc = await createPeerConnection(config, sdpConstraints);

    localStream = await CameraHelper.openCamera();

    localStream!.getTracks().forEach((track) {
      pc!.addTrack(track, localStream!);
    });

    _localRenderer.srcObject = localStream;

    pc!.onIceCandidate = (candidate) {
      _sendIce(candidate);
    };

    pc!.onAddStream = (stream) {
      _remoteRenderer.srcObject = stream;
    };

    socket.emit('join');
  }

  Future<void> _sendOffer() async {
    print("Sending offer");
    var offer = await pc!.createOffer();
    await pc!.setLocalDescription(offer);
    socket.emit('offer', jsonEncode(offer.toMap()));
  }

  Future<void> _gotOffer(RTCSessionDescription offer) async {
    await pc!.setRemoteDescription(offer);
  }

  Future<void> _sendAnswer() async {
    var answer = await pc!.createAnswer();
    await pc!.setLocalDescription(answer);
    socket.emit('answer', jsonEncode(answer.toMap()));
  }

  Future<void> _gotAnswer(RTCSessionDescription answer) async {
    await pc!.setRemoteDescription(answer);
  }

  Future<void> _sendIce(RTCIceCandidate ice) {
    socket.emit("ICE", jsonEncode(ice.toMap()));
    return Future.value();
  }

  Future<void> _gotIce(RTCIceCandidate ice) async {
    await pc!.addCandidate(ice);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Row(
        children: [
          Expanded(child: RTCVideoView(_localRenderer)),
          Expanded(child: RTCVideoView(_remoteRenderer)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    pc?.dispose();
    super.dispose();
  }
}

class CameraHelper {
  static Future<MediaStream?> openCamera() async {
    final mediaConstraints = {
      'audio': true,
      'video': {'facingMode': 'user'}
    };
    try {
      return await navigator.mediaDevices.getUserMedia(mediaConstraints);
    } catch (e) {
      print('Error opening camera: $e');
      return null;
    }
  }
}
