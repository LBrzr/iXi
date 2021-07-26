import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/models/quiz.dart';
import '/models/user.dart';
import '/blocs/quiz.dart';
import '/blocs/user.dart';
import '/widgets/loadingIcon.dart';
import '/widgets/profilePic.dart';
import '/widgets/customDivider.dart';
import '/widgets/optionButton.dart';
import '/widgets/delegate.dart';
import '/widgets/userQuizWidget.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with SingleTickerProviderStateMixin {
  static const double BAR_HEIGHT = 220.5, TITLE_LEFT_PADDING = 30;
  static final quizs = QuizBloc.instance, users = UserBloc.instance;
  final titleKey = GlobalKey();
  final scrollController = ScrollController();
  StreamSubscription subscription;
  User user;
  ThemeData theme;
  List<Quiz> quizList;
  Size size, titleSize = Size.zero;

  @override
  void initState() {
    user = users.user;
    subscription = quizs.fromUser.listen((quizs) => setState(() => this.quizList = quizs));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => titleSize = titleKey.currentContext.size);
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  get setSystemUIStyle => SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      )
  );

  double titleX(double pixels) => -(
      pixels < BAR_HEIGHT ? (pixels/BAR_HEIGHT) : 1)
      *(((size.width - titleSize.width)/2) -TITLE_LEFT_PADDING);

  Widget buildUserInfoLine({@required Widget child}) => ColoredBox(
    color: CupertinoColors.extraLightBackgroundGray,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
          height: 35,
          child: child
      ),
    ),
  );

  Widget buildQuizList(List<Quiz> data, [bool showAdd = false]) => data.length > 0 ? ListView.separated(
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.only(top: 24, bottom: 0),
    itemCount: data.length,
    separatorBuilder: (context, index) => ColoredBox(color: theme.backgroundColor, child: SizedBox(height: 8)),
    itemBuilder: (context, index) => UserQuizWidget(quiz: data[index]),
  ) : showAdd
      ? Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Vous n\'avez encore créé aucun quiz !'),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Cliquez ici pour en créer !'),
              Icon(Icons.arrow_downward_rounded),
            ],
          )
        ],
      ) : Center(child: Text('Aucun quiz à afficher !'));

  @override
  Widget build(BuildContext context) {
    setSystemUIStyle;
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  elevation: 0,
                  pinned: true,
                  actions: [
                    OptionButton(options: [
                        Text('Deconnexion'),
                        Text('Modifier les informations du profile'),
                        Text('Trier les quiz'),
                        Text('Trier les quiz')
                      ]
                    )
                  ],
                  expandedHeight: BAR_HEIGHT +60,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Padding(
                      padding: const EdgeInsets.only(top: 75, bottom: 60),
                      child: ProfilePic(url: user.pp, size: 60, iconSize: 70,),
                    ),
                    collapseMode: CollapseMode.pin,
                    title: AnimatedBuilder(
                      animation: scrollController,
                      builder: (context, child) => Transform.translate(
                        offset: Offset(titleX(scrollController.positions.first.pixels), 0),
                        child: child
                      ),
                      child: Text(user.username, key: titleKey)
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(.5),
                    child: AnimatedBuilder(
                        animation: scrollController,
                        builder: (context, child) {
                          if (scrollController.positions.first.pixels > BAR_HEIGHT -.5)
                            return child;
                          else return SizedBox.shrink();
                        },
                        child: CustomDivider()
                    ),
                  ),
                ),
                SliverList(delegate: SliverChildListDelegate([
                  buildUserInfoLine(child: Row(
                    children: [
                      Text('Email:  '),
                      Text(user.email, style: theme.textTheme.headline6,)
                    ],
                  )),
                  buildUserInfoLine(
                    child: Row(
                      children: [
                        Text('Level:  '),
                        Text(user.level.toDisplay, style: theme.textTheme.headline6)
                      ],
                    ),
                  ),
                ])),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: Delegate(
                    min: 50,
                    max: 50,
                    child: Column(
                      children: [
                        ColoredBox(
                          color: theme.backgroundColor,
                          child: TabBar(
                            tabs: quizList == null ? [
                              Tab(text: 'Tout',),
                              Tab(text: 'Privé',),
                              Tab(text: 'Public',),
                            ] : [
                              Tab(text: 'Tout (${quizList.length})',),
                              Tab(text: 'Privé (${quizList.where((quiz) => !quiz.visible).length})',),
                              Tab(text: 'Public (${quizList.where((quiz) => quiz.visible).length})',),
                            ]
                          )
                        ),
                        PreferredSize(
                          preferredSize: Size.fromHeight(.5),
                          child: AnimatedBuilder(
                              animation: scrollController,
                              builder: (context, child) {
                                if (scrollController.positions.first.pixels > BAR_HEIGHT +72.5)
                                  return child;
                                else return SizedBox.shrink();
                              },
                              child: CustomDivider()
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ];
            },
            body: quizList != null
              ? Transform.translate(
                offset: const Offset(0, -25),
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    buildQuizList(quizList, true),
                    buildQuizList(quizList.where((quiz) => !quiz.visible).toList(growable: false)),
                    buildQuizList(quizList.where((quiz) => quiz.visible).toList(growable: false))
                  ],
                )
              ) : LoadingIcon(),
        ),
      ),
    );
  }
}
