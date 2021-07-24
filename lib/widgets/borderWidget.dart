import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderWidget extends StatelessWidget {
  const BorderWidget({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 30,
      child: Material(
        color: theme.backgroundColor,
        elevation: .5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(width: .5, color: theme.disabledColor)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(child: child),
        ),
      ),
    );
  }
}
