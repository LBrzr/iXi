
import 'package:flutter/cupertino.dart';

class CustomIcons extends StatelessWidget {
  final String name;
  final double height;
  static const String path = 'assets/icons/';
  static final CustomIcons home_fill = CustomIcons('home_fill'),
      home_outlined = CustomIcons('home_outlined'),
      add_fill = CustomIcons('add_fill', 30),
      add_outlined = CustomIcons('add_outlined'),
      send_fill = CustomIcons('send_fill'),
      send_outlined = CustomIcons('send_outlined'),
      bubble_fill = CustomIcons('bubble_fill'),
      bubble_outlined = CustomIcons('bubble_outlined'),
      liked_fill = CustomIcons('liked_fill'),
      liked_outlined = CustomIcons('liked_outlined'),
      marked_fill = CustomIcons('marked_fill'),
      marked_outlined = CustomIcons('marked_outlined'),
      person_fill = CustomIcons('person_fill'),
      person_outlined = CustomIcons('person_outlined'),
      search_fill = CustomIcons('search_fill'),
      search_outlined = CustomIcons('search_outlined'),
      stats_fill = CustomIcons('stats_fill'),
      stats_outlined = CustomIcons('stats_outlined'),
      sort = CustomIcons('sort'),
      camera = CustomIcons('camera');

  CustomIcons(String name, [this.height = 25]) : name = path + name +'.png';

  @override
  Widget build(BuildContext context) {
    return Image.asset(name, height: height);
  }
}