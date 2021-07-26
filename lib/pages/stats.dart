import 'package:flutter/cupertino.dart';

import '/blocs/quiz.dart';
import '/widgets/loadingIcon.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  // todo static final UserBloc users = UserBloc.instance;
  static final QuizBloc quiz = QuizBloc.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: quiz.userStats,
      builder: (context, snapshot) {
        return snapshot.hasData
          ? Center(child: Text(snapshot.data.toString()))
          : LoadingIcon();
      },
    );
  }
}
