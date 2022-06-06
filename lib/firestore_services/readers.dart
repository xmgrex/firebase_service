import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_services/firestore_service.dart';

class Readers {
  DocumentReference document({required String path}) {
    return FirebaseFirestore.instance.doc(path);
  }

  CollectionReference collection({required String path}) {
    return FirebaseFirestore.instance.collection(path);
  }

  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('path: $path');
    return await reference
        .getCacheElseServer<Map<String, dynamic>>()
        .then((snapshot) {
      return builder(snapshot.data(), snapshot.id);
    });
  }

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    final reference = FirebaseFirestore.instance.collection(path);
    print('path: $path');
    return await reference.getCacheElseServer().then((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Future<List<T>> getCollectionLimited<T>({
    required String path,
    required int limit,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    final reference = FirebaseFirestore.instance.collection(path).limit(limit);
    print('path: $path');
    return await reference.get().then((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }
}
