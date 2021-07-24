import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/models/quiz.dart';

class LaunchQuizWidget extends StatelessWidget {

  const LaunchQuizWidget({Key key, @required this.child, @required this.quiz}) : super(key: key);

  final Widget child;
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Commencer le quiz ?'),
            action: SnackBarAction(
              onPressed: () {

              },
              label: 'Démarrer',
            ),
          )
        );
      },
      child: child
    );
  }
}
