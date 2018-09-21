import 'dart:async';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:scheduler_flutter/src/models/meal.dart';
import 'package:scheduler_flutter/src/pages/meal_detail.dart';
import 'package:scheduler_flutter/src/shared/meals_provider.dart';
import 'package:scheduler_flutter/src/shared/widgets/action_button.dart';
import 'package:scheduler_flutter/src/shared/widgets/alert_delete.dart';
import 'package:scheduler_flutter/src/shared/widgets/card-section.dart';
import 'package:scheduler_flutter/src/shared/widgets/card_title.dart';
import 'package:scheduler_flutter/src/shared/widgets/icon_label.dart';

class MealsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFf6fafd),
      margin: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[_mealsTitle(context), _mealsList(context)],
      ),
    );
  }

  CardTitle _mealsTitle(BuildContext context) {
    return CardTitle(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[_mealsLabel(), _btnAddMeals(context)],
    ));
  }

  ActionButton _btnAddMeals(BuildContext context) {
    return ActionButton(
        text: '+ NEW MEAL',
        fn: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MealDetail()));
        });
  }

  IconLabel _mealsLabel() {
    return IconLabel(icon: FontAwesomeIcons.heart, label: 'Your meals');
  }

  CardSection _mealsList(BuildContext context) {
    final mealsBloc = MealsProvider.of(context);

    return CardSection(
      child: StreamBuilder<List<Meal>>(
          stream: mealsBloc.meals$,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return Column(
                  children: snapshot.data
                      .map((meal) => MealTile(
                          meal: meal,
                          onRemove: () {
                            mealsBloc.delete.add(meal);
                          }))
                      .toList());
            }
            return Text('No meals, add a new meal to start',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500));
          }),
      showBottomBorder: false,
    );
  }
}

class MealTile extends StatelessWidget {
  final Meal meal;
  final Function onRemove;

  MealTile({this.meal, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_, __, ___) => MealDetail(meal: meal)));
          },
          child: ListTile(
              title: Text(meal.name),
              subtitle: Text(
                meal.food.join(', '),
                style: TextStyle(
                    color: Color(0xFF8ea6bd),
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic),
              )),
        ),
      ),
      IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () async {
          var delete = await _showAlertDelete(context);
          if (delete) onRemove();
        },
      )
    ]);
  }

  Future<bool> _showAlertDelete(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return showAlertDelete(context);
        });
  }
}
