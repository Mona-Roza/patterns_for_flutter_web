// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> pickImage(File? file) async {
    try {
      var snapshotRef = _firebaseStorage
          .ref()
          .child('${DateTime.now().microsecondsSinceEpoch}.jpg');

      await snapshotRef.putBlob(file);

      var downloadUrl = await snapshotRef.getDownloadURL();

      return downloadUrl;
    } on FirebaseException catch (e) {
      return 'error: $e';
    }
  }
}
