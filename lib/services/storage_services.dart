import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload file
  Future uploadFile(File file, String path) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = await ref.putFile(file);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }

  // Upload multiple files
  Future<List> uploadMultipleFiles(List files, String basePath) async {
    List urls = [];
    for (int i = 0; i < files.length; i++) {
      final url = await uploadFile(files[i], '$basePath/image_$i');
      urls.add(url);
    }
    return urls;
  }

  // Delete file
  Future deleteFile(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } catch (e) {
      throw Exception('Failed to delete file: $e');
    }
  }

  // Delete multiple files
  Future deleteMultipleFiles(List urls) async {
    for (String url in urls) {
      await deleteFile(url);
    }
  }
}
