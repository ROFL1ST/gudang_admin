// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, sized_box_for_whitespace
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gudang_admin/api/firebase_service.dart';

import 'package:gudang_admin/constants.dart';
import 'dart:developer';

class Add extends StatefulWidget {
  Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  FirebaseStorage storage = FirebaseStorage.instance;
  TextEditingController namaBarang = TextEditingController();
  TextEditingController stockBarang = TextEditingController();
  TextEditingController gambarBarang = TextEditingController();
  void UploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      String nama = result.files.first.name;

      try {
        await storage.ref('upload/$nama').putFile(file);
        log("Berhasil upload");
        // ignore: nullable_type_in_catch_clause
        var downloadURL = await storage.ref('upload/$nama').getDownloadURL();

        setState(() {
          gambarBarang.text = downloadURL;
        });
      } on FirebaseException catch (e) {
        // e.g, e.code == 'canceled'
        log(e.toString());
      }
    } else {
      // User canceled the picker
      log("Tidak memilih file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        backgroundColor: kPrimaryColor,
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListView(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: namaBarang,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Nama Barang",
                      labelText: "Barang",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(.5),
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: stockBarang,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Stock Barang",
                      labelText: "Stock",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(.5),
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: gambarBarang,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Url Barang",
                      labelText: "link",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(.5),
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(.5),
                      ),
                    ),
                  ),
                  SizedBox(height:  40,),
                  Container(
                    // padding: EdgeInsets.only(left: 15.0, right: 20.0),
                    height: 50,
                    width: 250,
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      shadowColor: kPrimaryColor.withOpacity(0.5),
                      color: kPrimaryColor,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                          UploadFile();
                        },
                        child: Center(
                          child: Text(
                            "Pick Picture",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 40.0, left: 15.0, right: 20.0),
                    height: 110,
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      shadowColor: kPrimaryColor.withOpacity(0.5),
                      color: kPrimaryColor,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                          Firebase_service().addProduct(
                              namaBarang.text,
                              int.parse(stockBarang.text),
                              gambarBarang.text,
                              context);
                        },
                        child: Center(
                          child: Text(
                            "Tambah Produk",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
