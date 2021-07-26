import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagListWidget extends StatelessWidget {
  const TagListWidget({Key key, @required this.tags, this.height = 22}) : super(key: key);

  final Set<String> tags;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: height,
      child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          children: tags.map<Widget>((tag) => Padding(
            padding: const EdgeInsets.only(right: 3),
            child: Text('#$tag', style: TextStyle(decoration: TextDecoration.underline, color: theme.primaryColorDark),),
          )).toList()..insert(0, Text('Quiz tags: '))
      ),
    );
  }
}
