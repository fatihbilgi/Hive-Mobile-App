import 'package:flutter/material.dart';

extension ListExtensions on List<Widget> {
  Widget row({CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center, MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start}) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: this,
    );
  }

  Widget column({CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center, MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start}) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: this,
    );
  }
}
