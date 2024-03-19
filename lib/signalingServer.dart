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
  MediaStream? remoteStream;
  String? currentRoomText;

  //creating room in database
  Future<String> createRoom(RTCVideoRenderer remoteRenderer) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomRef = db.collection('rooms').doc();

    //loading to save
    print('"creation de la configuration pour la connexion peer to peer loaaaading" : $configurations"');
    //creating function Peer to peer (P2P)
    peerConnection = await createPeerConnection(configurations);
    registerPeerConnectionListeners();


    //connecting peer to peer to add track != null
    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    //adding collection inside of the room
    var callerCandidatesCollection = roomRef.collection('Condidats');

    //prints each ICE candidate to the console and mapping ICE on the console
    peerConnection?.onIceCandidate = (RTCIceCandidate user) {
      print('Got candidate: ${user.toMap()}');
      callerCandidatesCollection.add(user.toMap());

    }; //finish the code for collecting ICE       ICE : Interactive Connectivity Establishment






    //creating room
    RTCSessionDescription offer = await peerConnection!.createOffer();
    await peerConnection!.setLocalDescription(offer);
    print('Created offer: $offer');

    Map<String, dynamic> roomWithOffer = {'offer': offer.toMap()};

    await roomRef.set(roomWithOffer);
    var roomId = roomRef.id;
    print('New room created. Room ID: $roomId');
    currentRoomText = 'Current room is $roomId - You are the caller!';
    // Created a Room

    peerConnection?.onTrack = (RTCTrackEvent event) {
      print('Got remote track: ${event.streams[0]}');

      event.streams[0].getTracks().forEach((track) {
        print('Add a track to the remoteStream $track');
        remoteStream?.addTrack(track);
      });
    };



















  }
