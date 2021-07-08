import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnexionRoute extends StatefulWidget {
  const ConnexionRoute({Key? key}) : super(key: key);

  @override
  _ConnexionRouteState createState() => _ConnexionRouteState();
}

class _ConnexionRouteState extends State<ConnexionRoute> with SingleTickerProviderStateMixin {
  late Size size;
  late ThemeData theme;
  late TabController tabController;
  late TextStyle textStyle, hintStyle;
  final UnderlineInputBorder inputBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid)),
    errorInputBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1, style: BorderStyle.solid));
  final GlobalKey<FormState> connexionFormKey = GlobalKey(), registrationFormKey = GlobalKey();
  final TextEditingController pseudoController = TextEditingController(),
      pwdController = TextEditingController(),
      confirmController = TextEditingController(),
      emailController = TextEditingController();

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

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

  TextFormField textField(String hint, TextEditingController controller, String? Function(String?)? validator,
      {TextInputType type: TextInputType.text, TextInputAction action: TextInputAction.next, void Function(String)? onSubmit, bool hide: false}) => TextFormField(
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
            padding: MaterialStateProperty.all(EdgeInsets.only(left: 5, right: 2))
          ),
          onPressed: () => navTo(index),
        ),
      ],
    ),
  );

  navTo(index) => tabController.animateTo(index, curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    textStyle = theme.textTheme.bodyText2!.copyWith(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic
    );
    hintStyle = theme.textTheme.bodyText2!.copyWith(
        color: Colors.white60,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic
    );

    final emailField = textField('Email', emailController, (val) => RegExp('[a-zA-Z0-9]+@[a-zA-Z]+.([a-zA-Z])+').hasMatch(val!) ? null : ' Email non valide', type: TextInputType.emailAddress);

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
                              'Bienvenue dans iXi !',
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        emailField,
                        textField('Mot de passe', pwdController, (val) => val!.length >= 8 ? null : 'doit comporter au moins 8 caractères.', hide: true, action: TextInputAction.done),
                        textLink('Pas encore inscrit,','Créer un compte.', 2),
                        whiteButton('Se Connecter', () => navTo(0), padH: 25, padV: 5)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Form(
                    key: registrationFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                  hint: Text('Niveau', style: hintStyle,),
                                  style: textStyle,
                                  selectedItemBuilder: (context) => [
                                    DropdownMenuItem<String>(
                                      child: Text('bouya'),
                                      value: 'Bouya0',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('bouya'),
                                      value: 'Bouya1',
                                    ),
                                  ],
                                  items: [
                                    DropdownMenuItem<String>(
                                      child: Text('bouya'),
                                      value: 'Bouya0',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('bouya'),
                                      value: 'Bouya1',
                                    ),
                                  ]
                              ),
                            ),

                          ],
                        ),
                        emailField,
                        textField('Pseudo', pseudoController, (val) => val!.length >= 3 ? null : 'doit comporter au moins 3 caractères.', type: TextInputType.name),
                        textField('Mot de passe', pwdController, (val) => val!.length >= 8 ? null : 'doit comporter au moins 8 caractères.', hide: true),
                        textField('Confirmez le mot de passe', confirmController, (val) => val == pwdController.text ? null : 'Mot de passe incorrect.',
                          hide: true, action: TextInputAction.done),
                        textLink('Déjà inscrit,','Connectez vous.', 1),
                        whiteButton('Créer un compte', () => navTo(0), padH: 25, padV: 5)
                      ],
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
