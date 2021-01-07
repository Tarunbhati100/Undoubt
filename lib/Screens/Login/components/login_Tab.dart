import 'package:Undoubt/constants.dart';
import 'package:flutter/material.dart';

class LoginTab extends StatelessWidget {
  final bool active;
  final String title;
  final Function _toggle;
  LoginTab(this.title, this.active,this._toggle);
  @override
  Widget build(BuildContext context) {
    return InkWell(
          child: Container(
        padding: EdgeInsets.all(8),
        color: active ? kPrimaryColor : kPrimaryLightColor,
        child: Text(title,
            style: TextStyle(color: active ? Colors.white : Colors.black)),
      ),
      onTap: _toggle,
    );
  }
}
