import 'package:firebase_service/firebase_service.dart';

class FirestoreDatabase {
  final service = FirestoreService.instance;

  //* Set */
  Future<void> setData(String id) async {
    final path = 'collection/$id';
    await service.set(path: path, data: {'id': id});
  }

  //* Update */
  Future<void> updateData(String id) async {
    final path = 'collection/$id';
    await service.update(path: path, data: {'id': id});
  }

  //* Delete */
  Future<void> deleteData(String id) async {
    final path = 'collection/$id';
    await service.delete(path: path);
  }

  //* Get */
  Future<dynamic> getData(String id) async {
    final path = 'collection/$id';
    final res = await service.getDocument(
      path: path,
      builder: ((data, documentID) => data!),
    );
    return res;
  }

  //* Stream */
  Stream<dynamic> streamData(String id) {
    final path = 'collection/$id';
    return service.documentStream(
      path: path,
      builder: ((data, documentID) => data!),
    );
  }

  //* Get collection */
  Future<List<dynamic>> getDataList(String id) async {
    final path = 'collection/$id';
    final res = await service.getCollection(
      path: path,
      builder: ((data, documentID) => data!),
    );
    return res;
  }

  //* Get collection in real time. */
  Stream<List<dynamic>> streamDataList(String id) {
    final path = 'collection/$id';
    return service.collectionStream(
      path: path,
      builder: ((data, documentID) => data!),
    );
  }

  //* Limit query. */
  Stream<List<dynamic>> streamDataListLimit(String id) {
    final path = 'collection/$id';
    return service.collectionStream(
      path: path,
      builder: ((data, documentID) => data!),
      limit: 20, //* <--- Just add a limit.
    );
  }
}
