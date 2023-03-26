import 'package:flutter/material.dart';

extension TodoRouter on BuildContext {
  push(Widget widget) =>
      Navigator.push(this, MaterialPageRoute(builder: (context) => widget));

  pop() => Navigator.pop(this);
}
