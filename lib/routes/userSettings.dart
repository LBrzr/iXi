import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserSettingsRoute extends StatefulWidget {
  const UserSettingsRoute({Key? key}) : super(key: key);

  @override
  _UserSettingsRouteState createState() => _UserSettingsRouteState();
}

class _UserSettingsRouteState extends State<UserSettingsRoute> with SingleTickerProviderStateMixin {
  late Size size;
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;

    return Scaffold(
        body: Center(child: Text('userSettings'))
    );
  }
}
