import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final storage = FirebaseStorage.instance;
  final fixImagesPath = "imagesAccount";

  // Get data from path
  Future getData(String fixPath, String nameFile) async {
    print("###########");
    print("Storage --> getData");
    print("###########");
    final url = await storage
        .ref()
        .child('$fixImagesPath/$fixPath/$nameFile')
        .getDownloadURL();
    return url;
  }

  // Upload data in a folder/nameOfData
  Future<void> uploadData(String fixPath, String nameFile, File file) async {
    print("###########");
    print("Storage --> uploadData");
    print("###########");
    await storage
        .ref()
        .child('$fixImagesPath/$fixPath/$nameFile')
        .putFile(file);
  }
}
