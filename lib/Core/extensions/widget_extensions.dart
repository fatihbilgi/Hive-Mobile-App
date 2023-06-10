import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget get expanded {
    return Expanded(child: this);
  }

  Widget flexible(int flex) {
    return Flexible(child: this, flex: flex);
  }

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }
}
