import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'blocs/user.dart';
import 'routes/createQuiz.dart';
import 'routes/connexion.dart';
import 'routes/settings.dart';
import 'routes/app.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  static final textTheme = Typography.blackCupertino.apply(fontFamily: 'Signika');

  bool get isLogged => UserBloc.instance.isLogged;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iXi',
      theme: ThemeData(
        primaryColor: Colors.white,
        primaryColorDark: Color(0xFF454597),
        primaryColorLight: Color(0xffB0B0FF),
        accentColor: Color(0xFF8181D5),
        dividerColor: Color(0xffB0B0FF),
        secondaryHeaderColor: Color(0xFFDB9C84),
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: CupertinoColors.lightBackgroundGray,
        disabledColor: Colors.black12,
        textTheme: textTheme,
        snackBarTheme: SnackBarThemeData(
          actionTextColor: Colors.green,
          backgroundColor: Colors.white,
          contentTextStyle: textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700),
          shape: Border(
            top: BorderSide(color: Colors.green, width: .5)
          ),
          elevation: 0
        ),
        bottomSheetTheme: BottomSheetThemeData(
          elevation: 1,
          modalElevation: 1,
          backgroundColor: Colors.white,
          modalBackgroundColor: Colors.white,
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }
        )
      ),
      routes: {
        '/': isLogged ? _appRoute : _connexionRoute,
        'app': _connexionRoute,
        'userSettings': _settingsRoute,
        'quiz': _quizRoute
      },
    );
  }
}

Widget _appRoute(BuildContext context) => AppRoute();
Widget _settingsRoute(BuildContext context) => SettingsRoute();
Widget _quizRoute(BuildContext context) => CreateQuizRoute();
Widget _connexionRoute(BuildContext context) => ConnexionRoute();