import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gudang_admin/add.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

class Firebase_service {
  late String value;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference products = firestore.collection("products");

    return products.snapshots();
  }

  

  void addProduct(
      String namaBarang, int stockBarang, String gambarBarang, context) async {
    CollectionReference products = firestore.collection("products");
    int count = 0;
    try {
      await products.add(
          {"nama_barang": namaBarang, "stock": stockBarang, "gambar": gambarBarang});
      Alert(
        context: context,
        type: AlertType.success,
        title: "Success",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.popUntil(context, (route) {
              return count++ == 2;
            }),
            width: 120,
          )
        ],
      ).show();
    } catch (e) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Something's wrong, i can feel it",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }
  void deleteData(String docId, context) async {
    DocumentReference products = firestore.collection("products").doc(docId);
    try {
      await products.delete();
      Alert(
        context: context,
        type: AlertType.success,
        title: "Success To Delete",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    } catch (e) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Something's wrong, i can feel it",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }
}
