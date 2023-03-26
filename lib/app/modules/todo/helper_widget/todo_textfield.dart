import 'package:elredtodo/app/core/themes/theme.dart';
import 'package:elredtodo/app/core/utils/constant.dart';
import 'package:flutter/material.dart';

Widget todoTextField(
    {required String hint,
    required TextEditingController controller,
    bool readOnly = false,
    void Function()? onTap}) {
  return TextField(
    controller: controller,
    cursorColor: lightColor,
    style: TextStyle(color: lightColor),
    readOnly: readOnly,
    onTap: onTap,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: greyColor),
      border: underLineBorder,
      enabledBorder: underLineBorder,
      focusedBorder: underLineBorder,
    ),
  );
}
