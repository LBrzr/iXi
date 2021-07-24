import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iXi/models/quiz.dart';

import 'QuizWidget.dart';
import 'loadingIcon.dart';

class FutureQuizListWidget extends StatelessWidget {

  const FutureQuizListWidget({@required this.future, Key key, @required this.separatorColor}) : super(key: key);

  final Color separatorColor;
  final Future<List<Quiz>> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Quiz>>(
          future: future,
          builder: (context, snapshot) {
            return snapshot.hasData ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              separatorBuilder: (context, index) => ColoredBox(color: separatorColor, child: SizedBox(height: 8)),
              itemBuilder: (context, index) => QuizWidget(quiz: snapshot.data[index]),
            ) : LoadingIcon();
          }
      );
  }
}
