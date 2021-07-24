import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/widgets/customDivider.dart';
import '/widgets/customIcons.dart';

class CreateQuizRoute extends StatefulWidget {
  const CreateQuizRoute({Key key}) : super(key: key);

  @override
  _CreateQuizRouteState createState() => _CreateQuizRouteState();
}

class _CreateQuizRouteState extends State<CreateQuizRoute> {

  ThemeData theme;
  Size size;
  List<Map<String, dynamic>> questions = [];

  void addQuestion() => setState(() => questions.add({
    'tags': [],
    'enunciation': null,
    'propositions': []
  }));

  void addProposition(int index, String content) => setState(() => questions[index]['propositions'] = {
    'content': content
  });

  void addEnunciation(int index, String enunciation) => setState(() => questions[index]['enunciation'] = enunciation);

  void addTag(int index, String tag) => setState(() => questions[index]['tag'] = tag);

  Widget buildQuestion(Map<String, dynamic> question) => Column(
    children: [
      Text(question['enunciation'] ?? 'énoncée'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      appBar: AppBar(
        elevation: 0,
        title: Text('Créer un nouveau Quiz'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(.5),
          child: CustomDivider(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SizedBox.fromSize(
              size: const Size.square(27),
              child: CustomIcons.add_outlined
            ),
          )
        ],
      ),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                    child: Row(
                      children: [
                        Text('Questions', style: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w600),),
                        Expanded(child: Divider(indent: 10, endIndent: 10, thickness: .5,)),
                        GestureDetector(
                          onTap: addQuestion,
                          child: CustomIcons('add_outlined', 20)
                        )
                      ],
                    ),
                  ),
                  if (questions.length < 2)
                    Center(child: Text(
                      'Ajoutez ' +(questions.length == 0 ? 'au moins deux questions' : 'encore une question'),
                      style: theme.textTheme.bodyText2.copyWith(fontStyle: FontStyle.italic))
                    )
                ]),
              ),
            ];
          },
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: questions.length,
            separatorBuilder: (context, index) => ColoredBox(color: theme.backgroundColor, child: SizedBox(height: 8)),
            itemBuilder: (context, index) => buildQuestion(questions[index]),
          )
      ),
    );
  }
}
