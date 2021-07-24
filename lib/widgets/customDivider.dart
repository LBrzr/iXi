import 'package:flutter/material.dart';

class CustomDivider extends Divider {
  const CustomDivider ({Key key, double indent}) : super(key: key, height: 0, indent: indent, endIndent: indent, thickness: .5);
}
