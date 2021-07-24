import 'package:flutter/material.dart';

import 'customIcons.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({Key key,@required this.url, this.size = 40, this.iconSize}) : super(key: key);

  final String url;
  final double size, iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: CircleBorder(side: BorderSide(width: 1, color: theme.disabledColor)),
      color: theme.backgroundColor,
      child: SizedBox.fromSize(
        size: Size.square(size),
        child: Center(
          child: Transform.translate(
            offset: const Offset(0, 5),
            child: CustomIcons('person_fill', iconSize ?? size *.85),
          ),
        ),
      ),
    );
  }
}
