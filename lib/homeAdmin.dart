// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gudang_admin/add.dart';
import 'package:gudang_admin/api/firebase_service.dart';
import 'package:gudang_admin/edit.dart';
import 'package:gudang_admin/search.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WareHouse App For Admin",
          style: TextStyle(fontSize: 23),
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                 TextField(
              onSubmitted: ((value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Search(search: value)))),
              controller: searchController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                icon: Icon(Icons.search, size: 34),
                hintText: "Cari Barang....",
                hintStyle: TextStyle(fontSize: 15),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot<Object?>>(
                  stream: Firebase_service().streamData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var listAllData = snapshot.data!.docs;
                      return Container(
                        height: 750,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: listAllData.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data = listAllData[index]
                                .data()! as Map<String, dynamic>;

                            return Container(
                              margin: EdgeInsets.fromLTRB(4, 5, 4, 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.amber,
                              ),
                              padding: EdgeInsets.only(top: 20, bottom: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  data["gambar"]))),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            " ${data["nama_barang"]}",
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          Text(
                                            " Stock: ${data["stock"]}",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          Text(
                                            " ${data["tgl_masuk"]}",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => Edit(
                                                              data: data,
                                                              docId:
                                                                  listAllData[
                                                                          index]
                                                                      .id)));
                                                },
                                                icon:
                                                    Icon(Icons.edit, size: 30),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Alert(
                                                    context: context,
                                                    type: AlertType.warning,
                                                    title:
                                                        "You want to delete this thing??",
                                                    desc: "delete",
                                                    buttons: [
                                                      DialogButton(
                                                        child: Text(
                                                          "Go back",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        width: 120,
                                                        color: Colors.red,
                                                      ),
                                                      DialogButton(
                                                        child: Text(
                                                          "Delete",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                        onPressed: () {
                                                          Firebase_service()
                                                              .deleteData(
                                                                  listAllData[
                                                                          index]
                                                                      .id,
                                                                  context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        width: 120,
                                                        color: Colors.amber,
                                                      )
                                                    ],
                                                  ).show();
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Add();
            }));
          },
          child: Icon(Icons.add_box_rounded)),
    );
  }
}
