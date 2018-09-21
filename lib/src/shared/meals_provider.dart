import 'package:flutter/material.dart';

import 'package:scheduler_flutter/src/shared/meals_bloc.dart';

class MealsProvider extends InheritedWidget {
  final MealsBloc bloc;

  MealsProvider({Key key, this.bloc, child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MealsBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(MealsProvider) as MealsProvider)
          .bloc;
}
