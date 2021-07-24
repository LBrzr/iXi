import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/blocs/tag.dart';
import '/blocs/quiz.dart';
import '/widgets/borderWidget.dart';
import '/widgets/delegate.dart';
import '/widgets/futureQuizListWidget.dart';
import '/widgets/optionButton.dart';
import '/widgets/customDivider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const TAGS_TEXT_HEIGHT = 27, TAGS_LIST_HEIGHT = 48.5;
  static final quiz = QuizBloc.instance, tags = TagBloc.instance;
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
        title: Material(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          child: TextField(
            decoration: InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              hintText: 'Recherche',
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              prefixIcon: Center(child: Icon(Icons.search_rounded, size: 22)),
              prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 35)
            ),
          ),
        ),
        actions: [
          OptionButton(options: [
              Text('Niveau'),
              Text('Tags'),
              Text('Trier les quiz')
            ]
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(.5),
          child: AnimatedBuilder(
              animation: scrollController,
              builder: (context, child) {
                if (scrollController.positions.first.pixels > TAGS_TEXT_HEIGHT -.5)
                  return child;
                else return SizedBox.shrink();
              },
              child: CustomDivider()
          ),
        ),
      ),
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                ColoredBox(
                  color: theme.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text('Tags', style: theme.textTheme.bodyText1),
                  ),
                )
              ]),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: Delegate(
                max: TAGS_LIST_HEIGHT,
                min: TAGS_LIST_HEIGHT,
                child: ColoredBox(
                  color: theme.backgroundColor,
                  child: SizedBox(
                    width: size.width,
                    height: TAGS_LIST_HEIGHT,
                    child: FutureBuilder<Set<String>>(
                        future: tags.all,
                        builder: (context, snapshot) {
                          return snapshot.hasData ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: BorderWidget(child: Text(snapshot.data.elementAt(index)),
                                  ))
                          ) : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                child: Material(
                                  borderRadius: BorderRadius.circular(8),
                                  color: theme.disabledColor, // .withOpacity(.15),
                                  child: SizedBox.fromSize(size: Size(85, 30))
                                ),
                              )
                          );
                        }
                    ),
                  ),
                ),
              ),
            )
          ];
        },
        body: FutureQuizListWidget(future: quiz.suggestions, separatorColor: theme.backgroundColor)
      ),
    );
  }
}
