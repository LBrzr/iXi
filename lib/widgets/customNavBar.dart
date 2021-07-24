import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iXi/models/customNavBarItem.dart';

import 'customDivider.dart';
import 'customIcons.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({Key key, @required this.onItemPressed, @required this.onPressed}) : super(key: key);

  final void Function(int) onItemPressed;
  final void Function() onPressed;

  @override
  _CustomBottomNavbarState createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  int selectedIndex;

  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
  }

  Widget buildButton(CustomBottomNavItem item) {
    return GestureDetector(
        onTap: () {
          widget.onItemPressed(item.index);
          setState(() => selectedIndex = item.index);
        },
        child: selectedIndex == item.index ? item.fill : item.outlined
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomBottomNavItem.home(0),
                CustomBottomNavItem.search(1),
                CustomBottomNavItem.stats(2),
                CustomBottomNavItem.person(3),
              ].map(buildButton).toList()
                ..insert(2, GestureDetector(
                    onTap: widget.onPressed,
                    child: Hero(tag: 'addButton', child: CustomIcons.add_fill)
                )),
            ),
          ),
        ],
      ),
    );
  }
}