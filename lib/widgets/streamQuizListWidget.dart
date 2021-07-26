import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iXi/models/quiz.dart';

import 'QuizWidget.dart';
import 'loadingIcon.dart';

class StreamQuizListWidget extends StatelessWidget {

  const StreamQuizListWidget({@required this.stream, Key key, @required this.separatorColor}) : super(key: key);

  final Color separatorColor;
  final Stream<List<Quiz>> stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Quiz>>(
          stream: stream,
          builder: (context, snapshot) {
            print('List ' +(snapshot.hasData ? 'gotten' : 'not yet gotten')); // todo
            print(snapshot.data?.length);
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
