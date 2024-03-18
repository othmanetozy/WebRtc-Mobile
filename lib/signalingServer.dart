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

Future<String> CreatingRoom(RTCVideoRenderer remoteRendere) async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomRef = db.collection('room').doc();
}
}