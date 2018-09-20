import 'package:flutter/material.dart';

import 'package:scheduler_flutter/src/shared/meals_bloc.dart';

class MealsProvider extends InheritedWidget {
  final MealsBloc mealsBloc;

  MealsProvider({Key key, MealsBloc mealsBloc, Widget child})
      : mealsBloc = mealsBloc ?? MealsBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MealsBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(MealsProvider) as MealsProvider)
          .mealsBloc;
}
