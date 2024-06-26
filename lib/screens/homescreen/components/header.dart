import 'package:flutter/material.dart';

import '../../../components/rounded_icon.dart';
import '../../../components/serchfield.dart';


class LayoutHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RoundedIcon(
          icondata: Icons.menu,
          onpress: () {
            print("clicked");
            Scaffold.of(context).openDrawer();
          },
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(child: SearchField()),
        SizedBox(
          width: 10,
        ),
        RoundedIcon(
          icondata: Icons.shopping_cart,
          onpress: () {
            print("cart clicked");
          },
        )
      ],
    );
  }
}
