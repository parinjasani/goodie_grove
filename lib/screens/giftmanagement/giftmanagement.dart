import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyeraproject/models/goodies.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';
// class GiftmanagementScreen extends StatefulWidget {
//   @override
//   State<GiftmanagementScreen> createState() => _GiftmanagementScreenState();
// }
//
// class _GiftmanagementScreenState extends State<GiftmanagementScreen> {
//   final _formKey = GlobalKey<FormState>(); // Form key to manage validation
//
//   final _productnameController = TextEditingController();
//   final _detailsController = TextEditingController();
//   final _creditController = TextEditingController();
//   final _serialcodeController = TextEditingController();
//
//   bool isPopular = false;
//   String? selectedValue;
//   final imagePicker = ImagePicker();
//   bool isSaving = false;
//   bool isUploading = false;
//
//   List<XFile> images = [];
//   List<String> imageUrls = [];
//   List categories = [
//     "Electronics",
//     "Stationery & Office Supplies",
//     "Apparel & Accessories",
//     "Home & Living",
//     "Food & Beverages",
//     "Wellness & Fitness",
//     "Travel Essentials",
//     "Gift Cards & Vouchers",
//     "Eco-Friendly Gifts",
//     "Personalized Gifts"
//   ];
//
//   var uuid = Uuid();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black87,
//       appBar: AppBar(
//         title: Text('Add Goodies'),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Center(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//               child: Form(
//                 key: _formKey, // Attach form key here
//                 child: Column(
//                   children: [
//                     SizedBox(height: 15),
//                     _buildCategoryDropdown(),
//                     SizedBox(height: 15),
//                     _buildTextFormField("Name", _productnameController),
//                     SizedBox(height: 15),
//                     _buildTextFormField("Details", _detailsController, maxLines: 3),
//                     SizedBox(height: 15),
//                     _buildTextFormField("Credits", _creditController, keyboardType: TextInputType.number),
//                     SizedBox(height: 15),
//                     _buildTextFormField("Serial Code", _serialcodeController),
//                     SizedBox(height: 15),
//                     _buildPickImageButton(),
//                     SizedBox(height: 15),
//                     _buildImageGrid(),
//                     SizedBox(height: 15),
//                     _buildSwitch(),
//                     SizedBox(height: 15),
//                     _buildSaveButton(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategoryDropdown() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         color: Colors.white,
//       ),
//       child: DropdownButtonFormField(
//         hint: Text(
//           "Choose category",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         validator: (value) {
//           if (value == null) {
//             return "Category must be selected";
//           }
//           return null;
//         },
//         value: selectedValue,
//         items: categories.map((e) {
//           return DropdownMenuItem<String>(
//             value: e,
//             child: Text(e.toString()),
//           );
//         }).toList(),
//         onChanged: (value) {
//           setState(() {
//             selectedValue = value.toString();
//           });
//         },
//       ),
//     );
//   }
//
//   Widget _buildTextFormField(String label, TextEditingController controller, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         color: Colors.white,
//       ),
//       child: TextFormField(
//         controller: controller,
//         maxLines: maxLines,
//         keyboardType: keyboardType,
//         validator: (value) {
//           if (value!.isEmpty) {
//             return "$label should not be empty";
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           hintText: "Enter $label",
//           floatingLabelBehavior: FloatingLabelBehavior.auto,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPickImageButton() {
//     return MaterialButton(
//       color: Colors.indigo,
//       minWidth: 20.h,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       onPressed: pickImage,
//       child: Text(
//         'PICK IMAGES',
//         style: TextStyle(fontSize: 18, color: Colors.white),
//       ),
//     );
//   }
//
//   Widget _buildImageGrid() {
//     return Container(
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//                   child: Image.network(File(images[index].path).path, height: 200, width: 200, fit: BoxFit.cover),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       images.removeAt(index);
//                     });
//                   },
//                   icon: const Icon(Icons.cancel_outlined),
//                 ),
//               ],
//             ),
//           );
//         },
//         itemCount: images.length,
//       ),
//       height: 45.h,
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
//     );
//   }
//
//   Widget _buildSwitch() {
//     return SwitchListTile(
//       title: Text("Is this Goodie Popular?", style: TextStyle(color: Colors.white)),
//       value: isPopular,
//       onChanged: (value) {
//         setState(() {
//           isPopular = value;
//         });
//       },
//     );
//   }
//
//   Widget _buildSaveButton() {
//     return MaterialButton(
//       minWidth: 20.h,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       onPressed: () {
//         if (_formKey.currentState!.validate()) {
//           save();
//         }
//       },
//       child: Stack(
//         children: [
//           Visibility(
//             visible: !isSaving,
//             child: Center(
//               child: Text("SAVE", style: TextStyle(fontSize: 20, color: Colors.white)),
//             ),
//           ),
//           Visibility(
//             visible: isSaving,
//             child: Center(child: CircularProgressIndicator(color: Colors.white,)),
//           ),
//         ],
//       ),
//       color: Colors.indigo,
//     );
//   }
//
//   void pickImage() async {
//     final List<XFile>? pickedImages = await imagePicker.pickMultiImage();
//     if (pickedImages != null) {
//       setState(() {
//         images.addAll(pickedImages);
//       });
//     } else {
//       print("No images selected");
//     }
//   }
//
//   void save() async {
//     setState(() {
//       isSaving = true;
//     });
//
//     await uploaImages();
//     await Goodies.addProducts(Goodies(
//       category: selectedValue,
//       id: uuid.v4(),
//       productname: _productnameController.text,
//       details: _detailsController.text,
//       credits: int.parse(_creditController.text),
//       serialcode: _serialcodeController.text,
//       imageUrls: imageUrls,
//       isPopular: isPopular,
//     )).whenComplete(() {
//       setState(() {
//         isSaving = false;
//         images.clear();
//         imageUrls.clear();
//         clearField();
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added")));
//       });
//     });
//   }
//
//   void clearField() {
//     _productnameController.clear();
//     _detailsController.clear();
//     _creditController.clear();
//     _serialcodeController.clear();
//     selectedValue = null;
//     isPopular = false;
//   }
//
//   Future<void> uploaImages() async {
//     for (var image in images) {
//       final url = await postImage(image);
//       imageUrls.add(url);
//     }
//   }
//
//   Future<String> postImage(XFile image) async {
//     setState(() {
//       isUploading = true;
//     });
//     Reference ref = FirebaseStorage.instance.ref().child("images/${image.name}");
//     await ref.putFile(File(image.path));
//     String downloadUrl = await ref.getDownloadURL();
//     setState(() {
//       isUploading = false;
//     });
//     return downloadUrl;
//   }
// }





class GiftmanagementScreen extends StatefulWidget {
  //const GiftmanagementScreen({super.key});

  @override
  State<GiftmanagementScreen> createState() => _GiftmanagementScreenState();
}

class _GiftmanagementScreenState extends State<GiftmanagementScreen> {
  final _productnameController = TextEditingController();
  final _detailsController = TextEditingController();
  final _creditController = TextEditingController();
  final _serialcodeController = TextEditingController();
  bool isPopular = false;
  String? selectedValue;
  final imagePicker = ImagePicker();
  bool isSaving = false;
  bool isUploading = false;
  List<XFile> images = [];
  List<String> imageUrls = [];
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
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text('Add Goodies '),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                children: [

                  SizedBox(
                    height: 15,
                  ),
                  Container(decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                    child: DropdownButtonFormField(
                      hint: Text("Choose category",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
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
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Container(decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "should not be empty";
                        }
                        return null;
                      },
                      controller: _productnameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        hintText: "Product name",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                    child: TextFormField(
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
                        labelText: "details",labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        hintText: "Product details",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "should not be empty";
                        }
                        return null;
                      },
                      controller: _creditController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Credits",labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        hintText: "Product Credits",
                        //errorText: erroremail,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "should not be empty";
                        }
                        return null;
                      },
                      controller: _serialcodeController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "serialcode",labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        hintText: "Product serialcode",
                        //errorText: erroremail,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                    color: Colors.indigo,
                    minWidth: 20.h,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    onPressed: () {
                      pickImage();
                    },
                    child: Text(
                      'PICK IMAGES',
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SwitchListTile(title:Text(" Is this Gooide Popular?",style: TextStyle(color: Colors.white)),value: isPopular, onChanged: (value) {
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
                    color: Colors.indigo,
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
    await Goodies.addProducts(Goodies(
        category: selectedValue,
        id: uuid.v4(),
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

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added")));


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
      //selectedValue="";
      _productnameController.clear();
      _detailsController.clear();
      _creditController.clear();
      _serialcodeController.clear();
      isPopular=false;
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
  }
}
