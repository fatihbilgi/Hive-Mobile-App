import 'package:flutter/material.dart';

extension IntExtensions on int {
  /// return SizedBox(height: [this])
  Widget get h {
    // ignore: unnecessary_this
    return SizedBox(height: this.toDouble());
  }

  /// return SizedBox(width: [this])
  Widget get w {
    // ignore: unnecessary_this
    return SizedBox(width: this.toDouble());
  }
}
