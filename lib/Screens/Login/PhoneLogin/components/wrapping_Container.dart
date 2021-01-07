import 'package:Undoubt/constants.dart';
import 'package:flutter/material.dart';

class WrappingContainer extends StatelessWidget {
  final Widget child;
  WrappingContainer({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40, right: 20, left: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: kPrimaryColor),
      ),
      child: child,
    );
  }
}
