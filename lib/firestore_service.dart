library firestore_service;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_services/firestore_services/readers.dart';
import 'package:firebase_services/firestore_services/streamers.dart';
import 'package:firebase_services/firestore_services/writers.dart';

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();
  static final firestoreInstance = FirebaseFirestore.instance;

  final writers = Writers();
  final readers = Readers();
  final streamers = Streamers();

  Future<bool> isExists({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('isExists: $path');
    final snapshot = await reference.get();
    return snapshot.exists;
  }

}

extension GetCacheElseServerExtension on DocumentReference {

  Future<DocumentSnapshot> getCacheElseServer() async {
    DocumentSnapshot? snapshot;
    snapshot = await _getFromCache();
    return snapshot ?? await _getFromServer();
  }

  Future<DocumentSnapshot> _getFromServer() => get();

  Future<DocumentSnapshot?> _getFromCache() async {
    try {
      return await get(const GetOptions(source: Source.cache));
    } catch (_) {
      return null;
    }
  }

}
