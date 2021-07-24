import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iXi/blocs/session.dart';
import 'package:iXi/widgets/delegate.dart';

import '/widgets/customDivider.dart';
import '/widgets/futureQuizListWidget.dart';
import '/widgets/optionButton.dart';

import '/blocs/quiz.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double HEIGHT = 50;
  static final quiz = QuizBloc.instance;
  final scrollController = ScrollController();
  ThemeData theme;
  Size size;

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
  Widget build(BuildContext context) {
    setSystemUIStyle;
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('iXi', style: theme.textTheme.headline5.copyWith(
            fontStyle: FontStyle.italic,
            fontFamily: 'Lobster',
            letterSpacing: 1
        )),
        actions: [
          OptionButton(options: [
            Text('Niveau'),
            Text('Trier les quiz')
          ]
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(.5),
          child: AnimatedBuilder(
              animation: scrollController,
              builder: (context, child) {
                if (scrollController.positions.first.pixels > .0)
                  return child;
                else return SizedBox.shrink();
              },
              child: CustomDivider()
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                floating: true,
                delegate: Delegate(
                    max: HEIGHT,
                    min: HEIGHT,
                    child: ColoredBox(
                        color: theme.backgroundColor,
                        child: TabBar(
                          tabs: [
                            Tab(text: 'Suggestions',),
                            Tab(text: 'Activités')
                          ],
                        )
                    )
                )
              ),
            ];
          },
          body: TabBarView(
            children: [
              FutureQuizListWidget(future: quiz.suggestions, separatorColor: theme.backgroundColor),
              ListView.builder(
                itemCount: 50,
                itemBuilder: (conetxt, index) => Center(child: Text('activités'))
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Session.instance.deleteSession,
      ),
    );
  }
}
