import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/pages/home.dart';
import '/pages/search.dart';
import '/pages/stats.dart';
import '/pages/user.dart';

import '/widgets/customNavBar.dart';

class AppRoute extends StatefulWidget {
  const AppRoute({Key key}) : super(key: key);

  @override
  _AppRouteState createState() => _AppRouteState();
}

class _AppRouteState extends State<AppRoute> with SingleTickerProviderStateMixin {
  Size size;
  ThemeData theme;
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 4);
    super.initState();
  }

  get setSystemUIStyle => SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      )
  );

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setSystemUIStyle;
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomePage(),
          SearchPage(),
          StatsPage(),
          UserPage()
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 40,
        width: size.width,
        child: CustomBottomNavbar(
          onPressed: () => Navigator.pushNamed(context, 'quiz'),
          onItemPressed: (index) => tabController.animateTo(index)
        ),
      ),
    );
  }
}
