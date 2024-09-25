import 'package:carousel_slider/carousel_slider.dart';
import 'package:finalyeraproject/components/Homecard.dart';
import 'package:flutter/material.dart';

import 'header.dart';

class Body extends StatelessWidget {
  List images = [
    "https://cdn.pixabay.com/photo/2016/11/23/18/12/bag-1854148_1280.jpg",
    "https://cdn.pixabay.com/photo/2023/05/06/01/34/t-shirt-7973404_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/11/23/18/12/bag-1854148_1280.jpg",
    "https://cdn.pixabay.com/photo/2023/05/06/01/34/t-shirt-7973404_1280.jpg"
  ];


  List categories=["Electronics","Stationery & Office Supplies","Apparel & Accessories","Home & Living","Food & Beverages","Wellness & Fitness",
  "Travel Essentials","Gift Cards & Vouchers","Eco-Friendly Gifts","Personalized Gifts"];

  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LayoutHeader(),
              Container(height: 10,),
              CarouselSlider(
                  items: images
                      .map((e) => Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  child: Image.network(e, fit: BoxFit.cover,height: 225,width: double.infinity,),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 225,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(colors: [
                                        Colors.blueAccent.withOpacity(0.2),
                                        Colors.redAccent.withOpacity(0.2),
                                      ])),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Title",style: TextStyle(fontSize: 20,color: Colors.white),),
                                    )),
                              )
                            ],
                          ))
                      .toList(),
                  options: CarouselOptions(autoPlay: true, height: 225)),
              Homecard(title: categories[0],),
              Homecard(title: categories[1],),
              Homecard(title: categories[2],),
              Homecard(title: categories[3],),
              Homecard(title: categories[4],),
              Homecard(title: categories[5],),
              Homecard(title: categories[6],),
              Homecard(title: categories[7],),
              Homecard(title: categories[8],),
              Homecard(title: categories[9],),


            ],
          ),
        ),
      ),
    );
  }
}
