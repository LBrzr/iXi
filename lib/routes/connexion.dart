import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iXi/blocs/level.dart';

import '/blocs/user.dart';
import '/models/user.dart';

class ConnexionRoute extends StatefulWidget {
  const ConnexionRoute({Key key, this.index = 0}) : super(key: key);

  final int index;

  @override
  _ConnexionRouteState createState() => _ConnexionRouteState();
}

class _ConnexionRouteState extends State<ConnexionRoute> with TickerProviderStateMixin {
  static final userBloc = UserBloc.instance;
  static final levels = LevelBloc.instance;
  Size size;
  ThemeData theme;
  TabController tabController;
  TextStyle textStyle, hintStyle;
  static final UnderlineInputBorder inputBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid)),
    errorInputBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1, style: BorderStyle.solid));
  final GlobalKey<FormState> connexionFormKey = GlobalKey(), registrationFormKey = GlobalKey();
  static final TextEditingController usernameController = TextEditingController(),
      pwdController = TextEditingController(),
      confirmController = TextEditingController(),
      emailController = TextEditingController();
  static String level, classYear;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3, initialIndex: widget.index);
    super.initState();
  }

  get setSystemUIStyle => SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light
      )
  );

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  ElevatedButton whiteButton(String text, Function() onPressed, {padH = 10.0, padV = .0}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
        child: Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          elevation: MaterialStateProperty.all(5),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          ))
      ),
    );
  }

  TextFormField textField(String hint, TextEditingController controller, String Function(String) validator,
      {TextInputType type: TextInputType.text, TextInputAction action: TextInputAction.next, void Function(String) onSubmit, bool hide: false}) => TextFormField(
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,
    cursorColor: Colors.white,
    style: textStyle,
    obscureText: hide,
    textInputAction: action,
    keyboardType: type,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.only(top: 25, left: 10, right: 10),
      border: inputBorder,
      enabledBorder: inputBorder,
      focusedBorder: inputBorder,
      errorBorder: errorInputBorder,
      hintStyle: hintStyle,
    ),
  );

  Widget textLink(String text, String clickable, int index) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 15),
    child: Row(
      children: [
        Expanded(child: Text(text, style: hintStyle, textAlign: TextAlign.end,)),
        TextButton(
          child: Text(clickable, style: textStyle),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.only(left: 10, right: 2))
          ),
          onPressed: () => navTo(index),
        ),
      ],
    ),
  );

  Widget dropDown(String hint, Stream<List<String>> stream, String value, Function(String) onChanged) => Flexible(
    child: AnimatedSize(
      duration: const Duration(milliseconds: 450), vsync: this,
      child: StreamBuilder<List<String>>(
          stream: stream,
          initialData: [],
          builder: (context, snapshot) {
            return DropdownButtonFormField<String>(
                dropdownColor: Colors.white54,
                elevation: 3,
                decoration: InputDecoration(
                  border: inputBorder,
                  enabledBorder: inputBorder,
                  focusedBorder: inputBorder,
                  errorBorder: errorInputBorder,
                  contentPadding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                ),
                iconEnabledColor: Colors.white,
                hint: Text(hint, style: hintStyle),
                style: textStyle,
                value: value,
                onChanged: onChanged,
                validator: (val) => val != null ? null : 'Champ obligatoire ',
                items: snapshot.data.map((text) => DropdownMenuItem<String>(
                  child: Text(text),
                  value: text,
                )).toList(growable: false)
            );
          }
      ),
    ),
  );

  navTo(index) => tabController.animateTo(index, curve: Curves.fastOutSlowIn);

  Future<User> login() => userBloc.login(username: usernameController.text, password: pwdController.text);
  Future<User> signUp() async {
    final lev = levels.find(level: level, classYear: classYear);
    if (lev != null)
      return userBloc.signup(email: emailController.text, password: pwdController.text, username: usernameController.text, level: lev);
    print('level not found'); // todo
    return null;
  }

  validate(GlobalKey<FormState> key, Future<User> Function() onValidate) {
    if (key.currentState.validate())
      onValidate().then((user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, 'app');
        } else Fluttertoast.showToast(msg: 'Erreur lors de la connexion');
      });
    else print('not valid'); // todo
  }

  @override
  Widget build(BuildContext context) {
    setSystemUIStyle;
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    textStyle ??= theme.textTheme.bodyText2.copyWith(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic
    );
    hintStyle ??= theme.textTheme.bodyText2.copyWith(
        color: Colors.white60,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic
    );

    final usernameField = textField('Nom d\'utilisateur', usernameController, (val) => val.length >= 3 ? null : 'doit comporter au moins 3 caractères.', type: TextInputType.name);

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/bkgd.png', fit: BoxFit.cover),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Scaffold(
            backgroundColor: Colors.white12,
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                Column(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Center(child: Image.asset('assets/images/iXi.png', width: size.width/2.2, height: size.width*1.42/2.2,))
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Bienvenue dans iXi ',
                              style: textStyle.copyWith(fontSize: 20)
                            ),
                            whiteButton('Commencer', () => tabController.animateTo(1)),
                          ],
                        )
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Form(
                    key: connexionFormKey,
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          usernameField,
                          textField('Mot de passe', pwdController, (val) => val.length >= 8 ? null : 'doit comporter au moins 8 caractères.', hide: true, action: TextInputAction.done),
                          textLink('Pas encore inscrit,','Créer un compte.', 2),
                          whiteButton('Se Connecter', () => validate(connexionFormKey, login), padH: 25.0, padV: 5.0)
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Form(
                    key: registrationFormKey,
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: level != null
                              ? [ dropDown('Niveau', levels.levelStream, level, (val) => setState(() => level = val)),
                                SizedBox(width: 30),
                                dropDown('Classe', levels.classYearStream(level), classYear, (val) => setState(() => classYear = val)), ]
                              : [dropDown('Niveau', levels.levelStream, level, (val) => setState(() => level = val))]
                          ),
                          textField('Email', emailController, (val) => RegExp('[a-zA-Z0-9]+@[a-zA-Z]+.([a-zA-Z])+').hasMatch(val) ? null : ' Email non valide', type: TextInputType.emailAddress),
                          usernameField,
                          textField('Mot de passe', pwdController, (val) => val.length >= 8 ? null : 'doit comporter au moins 8 caractères.', hide: true),
                          textField('Confirmez le mot de passe', confirmController, (val) => val == pwdController.text ? null : 'Mot de passe incorrect.',
                            hide: true, action: TextInputAction.done),
                          textLink('Déjà inscrit,','Connectez vous.', 1),
                          whiteButton('Créer un compte', () => validate(registrationFormKey, signUp), padH: 25.0, padV: 5.0)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
