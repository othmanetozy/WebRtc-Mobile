import 'dart:convert';

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
  final roomName = 'test'; // Nom de la salle de discussion

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
    // Connexion au serveur Socket.IO
    socket = IO.io("http://localhost:3000",
        IO.OptionBuilder().setTransports(['websocket']).build());

    // Gestion de la connexion réussie
    socket.onConnect((data) => print("Data connected"));

    // Gestion de l'événement 'join' envoyé par le serveur
    socket.on('join', (data) {
      print("Received 'join' event");
      // Une fois l'événement 'join' reçu, envoie une offre aux autres clients
      _sendOffer();
    });

    // Gestion de l'offre envoyée par un autre client
    socket.on('offer', (data) async {
      data = jsonDecode(data);
      await _gotOffer(RTCSessionDescription(data['sdp'], data['type']));
      await _sendAnswer();
    });

    // Gestion de la réponse envoyée par un autre client
    socket.on('answer', (data) {
      data = jsonDecode(data);
      _gotAnswer(RTCSessionDescription(data['sdp'], data['type']));
    });

    // Gestion des candidats ICE envoyés par un autre client
    socket.on("ICE", (data) {
      data = jsonDecode(data);
      _gotIce(RTCIceCandidate(
          data['condidat'], data['sdpMip'], data['sdpMlineIndex']));
    });
  }

  Future<void> joinRoom() async {
    // Configuration des serveurs ICE
    final config = {
      'iceServers': [
        {"url": "stun:stun2.l.google.com:19302"},
      ]
    };

    // Contraintes SDP pour l'offre et la réponse
    final sdpConstraints = {
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': true,
      },
      'optional': []
    };

    // Création de la connexion peer
    pc = await createPeerConnection(config, sdpConstraints);

    // Ouverture du flux local de la caméra
    localStream = await CameraHelper.openCamera();

    // Ajout des pistes du flux local à la connexion peer
    localStream!.getTracks().forEach((track) {
      pc!.addTrack(track, localStream!);
    });

    // Affichage du flux local
    _localRenderer.srcObject = localStream;

    // Gestion des candidats ICE locaux
    pc!.onIceCandidate = (candidate) {
      _sendIce(candidate);
    };

    // Gestion de l'ajout du flux distant
    pc!.onAddStream = (stream) {
      _remoteRenderer.srcObject = stream;
    };

    // Émission de l'événement 'join' pour rejoindre la salle de discussion
    socket.emit('join');
  }

  Future<void> _sendOffer() async {
    print("Sending offer");
    // Création d'une offre SDP locale
    var offer = await pc!.createOffer();
    await pc!.setLocalDescription(offer);
    // Envoi de l'offre au serveur
    socket.emit('offer', jsonEncode(offer.toMap()));
  }

  Future<void> _gotOffer(RTCSessionDescription offer) async {
    // Configuration de l'offre distante
    await pc!.setRemoteDescription(offer);
  }

  Future<void> _sendAnswer() async {
    // Création d'une réponse SDP locale
    var answer = await pc!.createAnswer();
    await pc!.setLocalDescription(answer);
    // Envoi de la réponse au serveur
    socket.emit('answer', jsonEncode(answer.toMap()));
  }

  Future<void> _gotAnswer(RTCSessionDescription answer) async {
    // Configuration de la réponse distante
    await pc!.setRemoteDescription(answer);
  }

  Future<void> _sendIce(RTCIceCandidate ice) {
    // Envoi du candidat ICE local au serveur
    socket.emit("ICE", jsonEncode(ice.toMap()));
    return Future.value();
  }

  Future<void> _gotIce(RTCIceCandidate ice) async {
    // Ajout du candidat ICE distant
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
// Ouvre la caméra pour obtenir un flux multimédia
      return await navigator.mediaDevices.getUserMedia(mediaConstraints);
    } catch (e) {
// Gère les erreurs liées à l'ouverture de la caméra
      print('Error opening camera: $e');
      return null;
    }
  }
}
