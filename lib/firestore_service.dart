library firestore_service;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_services/firestore_services/readers.dart';
import 'package:firebase_services/firestore_services/streamers.dart';
import 'package:firebase_services/firestore_services/writers.dart';

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  final firestoreInstance = FirebaseFirestore.instance;
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

extension DocumentGetCacheElseServerExtension on DocumentReference {

  Future<DocumentSnapshot<T>> getCacheElseServer<T>() async {
    DocumentSnapshot<T>? snapshot;
    snapshot = (await _getFromCache()) as DocumentSnapshot<T>?;
    return snapshot ?? (await _getFromServer()) as DocumentSnapshot<T>;
  }

  Future<DocumentSnapshot> _getFromServer<T>() => get();

  Future<DocumentSnapshot?> _getFromCache<T>() async {
    try {
      return await get(const GetOptions(source: Source.cache));
    } catch (_) {
      return null;
    }
  }
}

extension CollectionGetCacheElseServerExtension on CollectionReference {

  Future<QuerySnapshot<T>> getCacheElseServer<T>() async {
    QuerySnapshot<T>? snapshot;
    snapshot = (await _getFromCache()) as QuerySnapshot<T>?;
    return snapshot ?? (await _getFromServer()) as QuerySnapshot<T>;
  }

  Future<QuerySnapshot> _getFromServer<T>() => get();

  Future<QuerySnapshot?> _getFromCache<T>() async {
    try {
      return await get(const GetOptions(source: Source.cache));
    } catch (_) {
      return null;
    }
  }
}
