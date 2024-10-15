import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Firebase/firebase_singleton.dart';
//import '../../components/user.dart';
import '../../models/Employee.dart';
import '../../models/goodies.dart';


class GiftDetailsPage extends StatefulWidget {
  final Goodies goodies;

  GiftDetailsPage({required this.goodies});

  @override
  _GiftDetailsPageState createState() => _GiftDetailsPageState();
}

class _GiftDetailsPageState extends State<GiftDetailsPage> {
  bool _isRedeemed = false;
  FirebaseSingleton _firebaseSingleton = FirebaseSingleton();
  User? currentUser;
  Employee? employee;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    fetchEmployeeDetails();
  }

  Future<void> fetchEmployeeDetails() async {
    if (currentUser != null) {
      employee =
          await _firebaseSingleton.getOneEmployeeByUid(currentUser!.uid!);
      setState(() {});
    }
  }
  Future<void> _redeemGoodie() async {
    if (employee == null || employee!.credit == null) return;

    int userCredits = employee!.credit ?? 0;
    int giftCredits = widget.goodies.credits ?? 0;

    if (userCredits >= giftCredits) {
      // User has enough credits to redeem
      setState(() {
        _isRedeemed = true;
        employee!.credit = userCredits - giftCredits;
      });

      // Update credits in Firebase
      await _firebaseSingleton.updateEmployeeCredits(
          currentUser!.uid!, employee!.credit!);

      // Show success SnackBar
      _showSnackBar("Item Redeemed Successfully", Colors.green);

      // Add to history
      await _firebaseSingleton.addRedemptionHistory(currentUser!.email!,
          widget.goodies.productname ?? 'Unknown Product', giftCredits,widget.goodies.imageUrls);
    } else {
      // Not enough credits
      _showSnackBar("Not enough credits to redeem this item.", Colors.red);
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Redeem the goodie
  // Future<void> _redeemGoodie() async {
  //   if (employee == null || employee!.credit == null) return;
  //
  //   int userCredits = employee!.credit ?? 0;
  //   int giftCredits = widget.goodies.credits ?? 0;
  //
  //   if (userCredits >= giftCredits) {
  //     // User has enough credits to redeem
  //     setState(() {
  //       _isRedeemed = true;
  //       employee!.credit = userCredits - giftCredits;
  //     });
  //
  //     // Update credits in Firebase
  //     await _firebaseSingleton.updateEmployeeCredits(
  //         currentUser!.email!, employee!.credit!);
  //
  //     Fluttertoast.showToast(
  //       msg: "Item Redeemed Successfully",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor: Colors.green,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //
  //     // Add to history
  //     await _firebaseSingleton.addRedemptionHistory(currentUser!.email!,
  //         widget.goodies.productname ?? 'Unknown Product', giftCredits);
  //   } else {
  //     // Not enough credits
  //     Fluttertoast.showToast(
  //       msg: "Not enough credits to redeem this item.",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.goodies.productname ?? 'Gift Details'),
        // backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          // Image Carousel
          Container(
            height: 300,
            child: PageView.builder(
              itemCount: widget.goodies.imageUrls?.length ?? 0,
              itemBuilder: (ctx, index) {
                return Image.network(
                  widget.goodies.imageUrls![index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  widget.goodies.productname ?? 'Unknown Product',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 18),
                // Product Credits
                Text(
                  'Credits: ${widget.goodies.credits ?? 0}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 17),
                // Product Description
                Text(
                  widget.goodies.details ?? 'No details available',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                  ),
                ),
                SizedBox(height: 80),

                Center(
                  child: Container(
                    height: 65,
                    width: 200,
                    child: ElevatedButton(

                      onPressed: _isRedeemed ? null : _redeemGoodie,
                      child: Text(style: TextStyle(fontSize: 20,color: Colors.white),_isRedeemed ? 'Redeemed' : 'Redeem Now'),
                      style: ElevatedButton.styleFrom(
                        primary: _isRedeemed ? Colors.grey : Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ])),
      ),
    );
  }
}
