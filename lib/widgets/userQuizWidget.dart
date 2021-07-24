import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iXi/widgets/tagListWidget.dart';

import '/models/quiz.dart';

import 'QuizWidget.dart' show buildNote, buildQuestion;

class UserQuizWidget extends StatelessWidget {

  const UserQuizWidget({Key key, this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final size = MediaQuery.of(context).size;
    return ExpansionTile(
      backgroundColor: theme.backgroundColor,
      collapsedBackgroundColor: CupertinoColors.extraLightBackgroundGray,
      title: TagListWidget(tags: quiz.tags, height: 25,),
      subtitle: Row(
        children: [
          Text('Questions: ', style: theme.textTheme.bodyText2.copyWith(color: theme.textTheme.caption.color)),
          Text(quiz.questions.length.toString()),
          Expanded(
              child: Align(alignment: Alignment.centerRight, child: buildNote(quiz.note))
          )
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(quiz.visible ? CupertinoIcons.share_solid : CupertinoIcons.share),
      ),
      children: quiz.questions.map((question) => buildQuestion(question, quiz.questions.indexOf(question))).toList(growable: false),
    );
  }
}