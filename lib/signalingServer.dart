import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';


class Signaling {

  Map<String, dynamic> configurations = {
    'ServeurICE' : [
      {
        'urls' : [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302'
        ]
      }
    ]
  };

  RTCPeerConnection? peerConnection;
  MediaStream? localStream;

  //creating room in database
  Future<String> createRoom(RTCVideoRenderer remoteRenderer) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomRef = db.collection('rooms').doc();

    //loading to save
    print('"Creating Peertopeer connection with a config" : $configurations"');
    //creating function Peer to peer (P2P)
    peerConnection = await createPeerConnection(configurations);
    registerPeerConnectionListeners();


    //connecting peer to peer to add track != null
    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });


    var callerCandidatesCollection = roomRef.collection('callerCandidates');





















  }
