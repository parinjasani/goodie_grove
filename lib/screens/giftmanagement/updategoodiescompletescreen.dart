import 'dart:io';

import 'package:finalyeraproject/models/goodies.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';
class UpadateGoodiesScreen extends StatefulWidget {
  Goodies? goodies;

   UpadateGoodiesScreen({super.key,this.goodies});

  @override
  State<UpadateGoodiesScreen> createState() => _UpadateGoodiesScreenState();
}

class _UpadateGoodiesScreenState extends State<UpadateGoodiesScreen> {
  
  List categories = [
    "Electronics",
    "Stationery & Office Supplies",
    "Apparel & Accessories",
    "Home & Living",
    "Food & Beverages",
    "Wellness & Fitness",
    "Travel Essentials",
    "Gift Cards & Vouchers",
    "Eco-Friendly Gifts",
    "Personalized Gifts"
  ];
  final _productnameController = TextEditingController();
  final _detailsController = TextEditingController();
  final _creditController = TextEditingController();
  final _serialcodeController = TextEditingController();
  bool isPopular = false;
  String? selectedValue="";
  final imagePicker = ImagePicker();
  bool isSaving = false;
  bool isUploading = false;
  List<XFile> images = [];
  List<dynamic> imageUrls = [];
  @override
  void initState() {
    // TODO: implement initState
    selectedValue=widget.goodies!.category;
    _productnameController.text=widget.goodies!.productname!;
    _detailsController.text=widget.goodies!.details!;
    _serialcodeController.text=widget.goodies!.serialcode!;
    isPopular=widget.goodies!.isPopular!;
    _creditController.text=widget.goodies!.credits.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                children: [
                  Text(
                    "UPDATE GOODIE",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField(
                    hint: Text("Choose category"),
                    validator: (value) {
                      if (value == null) {
                        return "category must be selected";
                      }
                      return null;
                    },
                    value: selectedValue,
                    items: categories
                        .map((e) => DropdownMenuItem<String>(
                        value: e, child: Text(e.toString())))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value.toString();
                      });
                    },
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                    controller: _productnameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Product name",
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                    maxLines: 3,
                    controller: _detailsController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "details",
                      hintText: "Product details",
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                    controller: _creditController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Credits",
                      hintText: "Product Credits",
                      //errorText: erroremail,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                    controller: _serialcodeController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "serialcode",
                      hintText: "Product serialcode",
                      //errorText: erroremail,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)),
                                    child: Image.network(
                                        widget.goodies!.imageUrls![index],
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover)),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.goodies!.imageUrls!.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.cancel_outlined))
                              ],
                            ),
                          );
                        },
                        itemCount: widget.goodies!.imageUrls!.length),
                    height: 25.h,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  SizedBox(height: 15,),
                  MaterialButton(
                    color: Colors.black,
                    minWidth: 20.h,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    onPressed: () {
                      pickImage();
                    },
                    child: Text(
                      'PICK IMAGES',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // MaterialButton(
                  //   //color: Colors.black,
                  //   minWidth: 20.h,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15)),
                  //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  //   onPressed: () {
                  //     uploaImages();
                  //   },
                  //   child: Stack(
                  //     children: [
                  //       Visibility(
                  //         visible: isUploading ? false : true,
                  //         child: Text(
                  //           'UPLOAD IMAGES',
                  //           style: TextStyle(fontSize: 20, color: Colors.black),
                  //         ),
                  //       ),
                  //       Visibility(
                  //           visible: isUploading,
                  //           child: Center(child: CircularProgressIndicator())),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)),
                                    child: Image.network(
                                        File(images[index].path).path,
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.cover)),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        images.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.cancel_outlined))
                              ],
                            ),
                          );
                        },
                        itemCount: images.length),
                    height: 45.h,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SwitchListTile(title:Text(" Is this Gooide Popular?",style: TextStyle(color: Colors.black)),value: isPopular, onChanged: (value) {
                    setState(() {
                      isPopular=!isPopular;
                    });
                  },),
                  SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                    minWidth: 20.h,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    onPressed: () {
                      save();
                    },
                    child: Stack(
                      children: [
                        Visibility(
                            visible: isSaving ? false : true,
                            child: Center(
                                child: Text("SAVE",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)))),
                        Visibility(
                            visible: isSaving,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ))
                      ],
                    ),
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await uploaImages();
    await Goodies.updateProducts(
      widget.goodies!.id!
    ,Goodies(
        category: selectedValue,
        productname: _productnameController.text,
        details: _detailsController.text,
        credits: int.parse(_creditController.text),
        serialcode: _serialcodeController.text,
        imageUrls: imageUrls,
        isPopular: isPopular)).whenComplete(() {
      setState(() {
        isSaving=false;
        images.clear();
        imageUrls.clear();
        clearField();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upated")));


      });
    },);
    // FirebaseFirestore.instance
    //     .collection("Products")
    //     .add({"Images": imageUrls}).whenComplete(() {
    //   setState(() {
    //     isSaving = false;
    //     images.clear();
    //     imageUrls.clear();
    //   });
    // });
  }

  clearField(){
    setState(() {
      _productnameController.clear();
      _detailsController.clear();
      _creditController.clear();
      _serialcodeController.clear();
      isPopular=false;
      Navigator.pop(context);
    });
  }

  pickImage() async {
    final List<XFile>? pickIMage = await imagePicker.pickMultiImage();

    if (pickIMage != null) {
      setState(() {
        images.addAll(pickIMage);
      });
    } else {
      print("no images selected");
    }
  }

  Future postImage(XFile? imagefile) async {
    setState(() {
      isUploading = true;
    });
    String urls;
    Reference ref =
    FirebaseStorage.instance.ref().child("images").child(imagefile!.name);
    if (kIsWeb) {
      await ref.putData(
        await imagefile.readAsBytes(),
        SettableMetadata(contentType: "image/jpeg"),
      );
      urls = await ref.getDownloadURL();
      setState(() {
        isUploading = false;
      });
      return urls;
    }
  }

  uploaImages() async {
    for (var image in images) {
      await postImage(image).then((value) => imageUrls.add(value));
    }
    imageUrls.addAll(widget.goodies!.imageUrls!);
  }
}
