import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iXi/models/question.dart';
import 'package:iXi/widgets/launchQuizWidget.dart';
import 'package:iXi/widgets/tagListWidget.dart';

import '/widgets/profile.dart';
import '/models/quiz.dart';

Widget buildQuestion(Question question, int index) => Padding(
  padding: const EdgeInsets.fromLTRB(20, 3, 10, 1.5),
  child: Row(
    children: [
      Text('N°${index+1}.  '),
      Expanded(child: Text(question.enunciation, overflow: TextOverflow.ellipsis,))
    ],
  ),
);

Widget buildNote(num note) => Text('$note/5', style: TextStyle(fontWeight: FontWeight.w700)); // todo

class QuizWidget extends StatelessWidget {
  const QuizWidget({Key key, @required this.quiz, this.showShare = false}) : super(key: key);

  final Quiz quiz;
  final bool showShare;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final size = MediaQuery.of(context).size;
    return LaunchQuizWidget(
      quiz: quiz,
      child: ColoredBox(
        color: CupertinoColors.extraLightBackgroundGray,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Profile(user: quiz.creator),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Questions: ', style: theme.textTheme.bodyText2.copyWith(color: theme.textTheme.caption.color)),
                                  Text(quiz.questions.length.toString())
                                ],
                              ),
                            ),
                            buildNote(quiz.note)
                          ],
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TagListWidget(tags: quiz.tags),
                      buildQuestion(quiz.questions[0], 0),
                      buildQuestion(quiz.questions[1], 1),
                    ],
                  ),
                ),
                if (showShare) Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(quiz.visible ? CupertinoIcons.share_solid : CupertinoIcons.share),
                )
              ],
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
