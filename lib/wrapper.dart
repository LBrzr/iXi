import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iXi/routes/connexion.dart';
import 'package:iXi/routes/userSettings.dart';

import 'routes/app.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  bool get isLogged => false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light
      )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        primaryColorDark: Color(0xFF454597),
        primaryColorLight: Color(0xffB0B0FF),
        accentColor: Color(0xFF8181D5),
        secondaryHeaderColor: Color(0xFFDB9C84),
        textTheme: Typography.blackCupertino.apply(fontFamily: 'Signika')
      ),
      routes: {
        '/': isLogged ? _appRoute : _connexionRoute,
        'app': _connexionRoute,
        'userSettings': _userRoute
      },
    );
  }
}

Widget _appRoute(BuildContext context) => AppRoute();
Widget _userRoute(BuildContext context) => UserSettingsRoute();
Widget _connexionRoute(BuildContext context) => ConnexionRoute();