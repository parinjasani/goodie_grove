import 'package:cloud_firestore/cloud_firestore.dart';

class Goodies {
  String? category;
  String? id;
  String? productname;
  String? details;
  int? credits;
  String? serialcode;
  List<dynamic>? imageUrls;
  bool? isPopular;

  Goodies(
      {required this.category,
         this.id,
        required this.productname,
        required this.details,
        required this.credits,
        required this.serialcode,
        required this.imageUrls,
        required this.isPopular});





  static Future<void> addProducts(Goodies g) async{
    CollectionReference db=FirebaseFirestore.instance.collection("products");
    Map<String,dynamic> data={
      "category":g.category,
      "productname":g.productname,
      "id":g.id,
      "details":g.details,
      "credits":g.credits,
      "serialcode":g.serialcode,
      "imageUrls":g.imageUrls,
      "isPopular":g.isPopular,
    };
    await db.add(data);
  }

  static Future<void> updateProducts(String id,Goodies gu) async{
    CollectionReference db=FirebaseFirestore.instance.collection("products");
    Map<String,dynamic> data={
      "category":gu.category,
      "productname":gu.productname,
      "details":gu.details,
      "credits":gu.credits,
      "serialcode":gu.serialcode,
      "imageUrls":gu.imageUrls,
      "isPopular":gu.isPopular,
    };
    await db.doc(id).update(data);
  }

  static Future<void> deleteProducts(String id) async{
    CollectionReference db=FirebaseFirestore.instance.collection("products");
    await db.doc(id).delete();
  }
}
