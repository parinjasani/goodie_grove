import 'package:flutter/material.dart';
import '../models/goodies.dart';

class GiftCard extends StatelessWidget {
  final Goodies goodies;

  GiftCard({required this.goodies});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(goodies.imageUrls?.first ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Product Name and Credits
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              goodies.productname ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '${goodies.credits ?? 0} Credits',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
