import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../../../utils/generate_unique_path.dart';

class ImageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadPackageImage(String localFilePath) async {
    try {
      final path = generateUniquePath();

      final file = File(localFilePath);

      final Reference ref = _storage.ref().child(path);
      final TaskSnapshot snapshot = await ref.putFile(file);
      final String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      throw ('Error uploading image to the server');
    }
  }
}
