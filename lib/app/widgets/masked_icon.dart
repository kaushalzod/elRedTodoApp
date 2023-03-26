import 'package:elredtodo/app/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

Widget maskedIcon(IconData icon,
    {Color? backgroundColor,
    bool shaderWhite = false,
    Color borderColor = Colors.black12,
    List<Color>? customShader}) {
  return Container(
    decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor)),
    padding: const EdgeInsets.all(12),
    child: ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return ui.Gradient.linear(
          const Offset(0, 25),
          const Offset(25, 0),
          customShader ??
              (shaderWhite
                  ? [Colors.white, Colors.white]
                  : [secondaryColor.withOpacity(0.5), primaryColor]),
        );
      },
      child: Icon(icon),
    ),
  );
}
