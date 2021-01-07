import 'package:Undoubt/components/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:Undoubt/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String title;
  final bool show;
  final Function toggle;
  final FormFieldValidator<String> validator;
  const RoundedPasswordField(
      {Key key,
      this.onChanged,
      this.title,
      this.show,
      this.validator,
      this.toggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: show ?? true,
        onChanged: onChanged,
        validator: validator,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: title,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: show
                ? Icon(
                    Icons.visibility,
                    color: kPrimaryColor,
                  )
                : Icon(
                    Icons.visibility_off,
                    color: kPrimaryColor,
                  ),
            onPressed: toggle,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
