import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scheduler_flutter/src/models/meal.dart';

import 'package:scheduler_flutter/src/shared/app_bar.dart';
import 'package:scheduler_flutter/src/shared/widgets/card_title.dart';
import 'package:scheduler_flutter/src/shared/widgets/icon_label.dart';
import 'package:scheduler_flutter/src/widgets/meal_form.dart';

class MealDetail extends StatefulWidget {
  final Meal meal;

  MealDetail({meal}) : this.meal = meal ?? Meal();

  @override
  _MealDetailState createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Card(
            color: Color(0xFFf6fafd),
            margin: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _mealTitle(),
                MealForm(widget.meal),
              ],
            ),
          ),
        ));
  }

  CardTitle _mealTitle() {
    return CardTitle(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[_mealLabel()],
    ));
  }

  IconLabel _mealLabel() {
    return IconLabel(
        icon: FontAwesomeIcons.heart,
        label: widget.meal.isUpdate() ? 'Save' : 'Create meal');
  }
}
