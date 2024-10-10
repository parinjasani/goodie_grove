import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyeraproject/components/Homecard.dart';
import 'package:flutter/material.dart';

import '../../../components/gift_card.dart';
import '../../../models/goodies.dart';
import 'header.dart';
import 'package:finalyeraproject/screens/goodiedetailscreen/goodies_detail.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            LayoutHeader(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('products').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error fetching data'));
                  }

                  // Extract products from Firestore snapshot
                  var products = snapshot.data!.docs.map((doc) {
                    return Goodies(
                      category: doc['category'],
                      id: doc.id,
                      productname: doc['productname'],
                      details: doc['details'],
                      credits: doc['credits'],
                      serialcode: doc['serialcode'],
                      imageUrls: doc['imageUrls'],
                      isPopular: doc['isPopular'],
                    );
                  }).toList();

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        // Carousel for Featured Products
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 200.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                          ),
                          items: products.map((goodies) {
                            return GestureDetector(
                              onTap: () {
                                // Navigate to Gift Details Page on click
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GiftDetailsPage(goodies: goodies),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(goodies.imageUrls?.first ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Removed text from the carousel
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20),
                        // Grid View for other products
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(10),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: products.length,
                          itemBuilder: (ctx, i) {
                            final goodies = products[i];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GiftDetailsPage(goodies: goodies),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black38.withOpacity(0.2),//Color(0xFF4E5452), // GridView background color
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                      child: Image.network(
                                        goodies.imageUrls?.first ?? '',
                                        height:150 ,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            goodies.productname ?? '',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            goodies.details ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Credits: ${goodies.credits ?? 0}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:finalyeraproject/components/Homecard.dart';
// import 'package:flutter/material.dart';
//
// import '../../../components/gift_card.dart';
// import '../../../models/goodies.dart';
// import 'header.dart';
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// import 'package:finalyeraproject/screens/goodiedetailscreen/goodies_detail.dart';
//
//
//
// class Body extends StatelessWidget {
//
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             LayoutHeader(),
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance.collection('products').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (snapshot.hasError) {
//           return Center(child: Text('Error fetching data'));
//         }
//
//         // Extract products from Firestore snapshot
//         var products = snapshot.data!.docs.map((doc) {
//           return Goodies(
//             category: doc['category'],
//             id: doc.id,
//             productname: doc['productname'],
//             details: doc['details'],
//             credits: doc['credits'],
//             serialcode: doc['serialcode'],
//             imageUrls: doc['imageUrls'],
//             isPopular: doc['isPopular'],
//           );
//         }).toList();
//
//         return SingleChildScrollView(
//           child: Column(
//             children: [
//               // Carousel for Featured Products
//               CarouselSlider(
//                 options: CarouselOptions(
//                   height: 200.0,
//                   autoPlay: true,
//                   enlargeCenterPage: true,
//                 ),
//                 items: products.map((goodies) {
//                   return GestureDetector(
//                     onTap: () {
//                       // Navigate to Gift Details Page on click
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => GiftDetailsPage(goodies: goodies),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       margin: EdgeInsets.all(5.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         image: DecorationImage(
//                           image: NetworkImage(goodies.imageUrls?.first ?? ''),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           goodies.productname ?? '',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             backgroundColor: Colors.black54,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 20),
//               // Grid View for other products
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 padding: const EdgeInsets.all(10),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 3 / 4,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemCount: products.length,
//                 itemBuilder: (ctx, i) {
//                   final goodies = products[i];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => GiftDetailsPage(goodies: goodies),
//                         ),
//                       );
//                     },
//                     child: GiftCard(goodies: goodies),
//                   );
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     ),
// //                 stream: FirebaseFirestore.instance.collection('products').snapshots(),
// //                 builder: (context, snapshot) {
// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return Center(child: CircularProgressIndicator());
// //                   }
// //
// //                   if (snapshot.hasError) {
// //                     return Center(child: Text('Error fetching data'));
// //                   }
// //
// //                   var products = snapshot.data!.docs.map((doc) {
// //                     return Goodies(
// //                       category: doc['category'],
// //                       id: doc.id,
// //                       productname: doc['productname'],
// //                       details: doc['details'],
// //                       credits: doc['credits'],
// //                       serialcode: doc['serialcode'],
// //                       imageUrls: doc['imageUrls'],
// //                       isPopular: doc['isPopular'],
// //                     );
// //                   }).toList();
// //
// //                   return GridView.builder(
// //
// //                     padding: const EdgeInsets.all(10),
// //                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                       crossAxisCount: 2,
// //                       childAspectRatio: 5/6,
// //                       crossAxisSpacing: 10,
// //                       mainAxisSpacing: 10,
// //                     ),
// //                     itemCount: products.length,
// //                     itemBuilder: (ctx, i) => GiftCard(goodies: products[i]),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
//     ),
//     ]),
//     ),
//     );
//   }
//  }
