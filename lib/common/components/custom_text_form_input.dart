import 'package:flutter/material.dart';
import 'package:restaurant_mobile/common/const/colors.dart';

class CustomTextFormInput extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autoFocus;
  final ValueChanged<String> onChanged;

  const CustomTextFormInput({
    super.key,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autoFocus = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0),
    );

    return TextFormField(
      autofocus: autoFocus,
      obscureText: obscureText,
      onChanged: onChanged,
      cursorColor: PRIMARY_COLOR,

      decoration: InputDecoration(
        border: baseBorder,
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
        fillColor: INPUT_BG_COLOR,
        filled: true,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
