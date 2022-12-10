import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_service/src/service.dart';

class Readers {

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
    int? limit,
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

}
