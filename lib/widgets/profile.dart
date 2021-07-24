import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iXi/widgets/profilePic.dart';

import '/models/user.dart';

class Profile extends StatelessWidget {
  const Profile({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: ProfilePic(url: user.pp),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.username, style: theme.textTheme.bodyText1),
            Text(user.level.toDisplay, style: theme.textTheme.bodyText2.copyWith(color: theme.textTheme.caption.color),)
          ],
        )
      ],
    );
  }
}