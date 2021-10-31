import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levant/model/modelAccount/profile.dart';
import 'package:levant/database/storage.dart';

class Db {
  final database = FirebaseFirestore.instance;
  final storage = Storage();
  final String id = "users";
  final user = Get.put(Profile());

  Future userExist(String uid) async {
    bool exist = false;
    await database
        .collection(id)
        .doc(uid)
        .get()
        .then((value) => exist = value.exists);
    return exist;
  }

  // Get data from every documents from a collection
  Future getData() async {
    final list = await database.collection(id).get();
    var data = [];
    // ignore: avoid_function_literals_in_foreach_calls
    list.docs.forEach((e) => data.add(e.data()));
    // List of JSON file
    return data;
  }

  // Data from specific document
  Future dataDocument(String doc) async {
    print("Calling: (database | dataDocument)");

    final d = await database.collection(id).doc(doc).get();
    return d.data();
  }

  // Data from specific key
  Future getSpecificDataKey(String doc, String key) async {
    print("Calling: (database | dataDocument)");

    final d = await database.collection(id).doc(doc).get();
    return d.data()![key];
  }

  // DB Creation
  Future creationDb(String uid, Map<String, dynamic> data) async {
    print("Creation: (database | creationDb)");
    var urlImg = "";

    if (data['Image'].isNotEmpty) {
      if (data['Image'].substring(0, 4) == "http") urlImg = data['Image'];
    }

    data['Image'] = urlImg;
    user.imgProfile = urlImg;

    await database.collection(id).doc(uid).set(data);
  }

  // Update data from document
  Future updateData(String uid, Map<String, dynamic> newData) async {
    // newData={'key': value} --> they must already exist
    print("Creation: (database | updateData)");
    await database.collection(id).doc(uid).update(newData);
  }

  // Delete document
  Future deleteData(String coll, BuildContext context) async {
    print("Creation: (database | deleteData)");
    await database.collection(coll).doc(id).delete();
  }
}
