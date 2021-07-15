import 'package:flutter/material.dart';

import 'blocs/session.dart';
import 'wrapper.dart';

Future get initialize async {
  await Session.instance.initialize();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize;
  runApp(Wrapper());
}