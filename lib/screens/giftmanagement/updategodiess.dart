import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyeraproject/models/goodies.dart';
import 'package:finalyeraproject/routes/approutes.dart';
import 'package:flutter/material.dart';

class UpadateGoodies extends StatelessWidget {
  const UpadateGoodies({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "UPDATE GODIES",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          StreamBuilder(
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data == null) {
                return Center(
                  child: Text("No product EXISTS"),
                );
              }
              final data = snapshot.data!.docs;
              return Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: ListTile(
                                  title: Text(
                                    data[index]['productname'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 13),
                                  ),
                                  trailing: Container(
                                    width: 200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Goodies.deleteProducts(data[index].id);
                                            },
                                            color: Colors.white,
                                            icon: Icon(Icons.delete)),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  Approutes
                                                      .updategoodiescompletescreen,
                                                  arguments: Goodies(
                                                      category: data[index]
                                                          ["category"],
                                                      id: data[index].id,
                                                      productname: data[index]
                                                          ["productname"],
                                                      details: data[index]
                                                          ["details"],
                                                      credits: data[index]
                                                          ["credits"],
                                                      serialcode: data[index]
                                                          ["serialcode"],
                                                      imageUrls: data[index]
                                                          ["imageUrls"],
                                                      isPopular: data[index]
                                                          ["isPopular"]));
                                            },
                                            color: Colors.white,
                                            icon: Icon(Icons.edit)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      );
                    },
                    itemCount: snapshot.data!.docs.length),
              );
            },
            stream:
                FirebaseFirestore.instance.collection("products").snapshots(),
          )
        ],
      ),
    );
  }
}
