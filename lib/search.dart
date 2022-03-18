import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gudang_admin/api/firebase_service.dart';

import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  final String search;
  const Search({Key? key, required this.search}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page"),
        backgroundColor: Colors.amber,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: Firebase_service().streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllData = snapshot.data!.docs;
            var data1 = listAllData
                .where((element) => element["nama_barang"]
                    .toString()
                    .toLowerCase()
                    .contains(widget.search))
                .toList();
            return Container(
              height: 680,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: data1.length,
                itemBuilder: (context, i) {
                  Map<String, dynamic> data =
                      data1[i].data()! as Map<String, dynamic>;

                  return Column(
                    children: [
                      Text(
                        "Search: ${widget.search}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
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
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(data["gambar"]))),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    SizedBox(height: 30)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
