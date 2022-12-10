This package includes FirestoreService, a wrapper class for the cloud_firestore APIs.

FirestoreService uses generics and the builder pattern to provide a type-based abstraction on top of cloud_firestore.

It covers only a very limited subset of APIs from cloud_firestore.

# Getting started

In your flutter project add the dependency:
```
dependencies:
  firebase_service: ^<version>
```

Import package:
```dart
import 'package:firebase_service/firebase_service.dart';
```

# Usage

Create instance:
```dart
final service = FirestoreService.instance;
```

To write a document:
```dart
    final path = 'collection/$id';
    await service.set(path: path, data: {'id': id});
```

To update a document:
```dart
    final path = 'collection/$id';
    await service.update(path: path, data: {'id': id});
```

To delete a document:
```dart
  Future<void> deleteData(String id) async {
    final path = 'collection/$id';
    await service.delete(path: path);
  }
```

To get a document:
```dart
    final path = 'collection/$id';
    final res = await service.getDocument(
      path: path,
      builder: ((data, documentID) => data!),
    );
```

To stream a document:
```dart
    final path = 'collection/$id';
    final res = service.documentStream(
      path: path,
      builder: ((data, documentID) => data!),
    );
```

To stream a collection:
```dart
    final path = 'collection/$id';
    final res = service.collectionStream(
      path: path,
      builder: ((data, documentID) => data!),
    );
```

To get a collection:
```dart
    final path = 'collection/$id';
    final res = await service.getCollection(
      path: path,
      builder: ((data, documentID) => data!),
    );
```

To get a collection with limit:
```dart
    final path = 'collection/$id';
    final res = service.collectionStream(
      path: path,
      builder: ((data, documentID) => data!),
      limit: 20, //* <--- Just add a limit.
    );
```
