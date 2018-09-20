import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scheduler_flutter/src/models/meal.dart';

import 'package:scheduler_flutter/src/shared/app_bar.dart';
import 'package:scheduler_flutter/src/shared/meals_provider.dart';
import 'package:scheduler_flutter/src/shared/widgets/action_button.dart';
import 'package:scheduler_flutter/src/shared/widgets/card-section.dart';
import 'package:scheduler_flutter/src/shared/widgets/card_title.dart';
import 'package:scheduler_flutter/src/shared/widgets/icon_label.dart';

class MealDetail extends StatefulWidget {
  final Meal meal;

  MealDetail({this.meal});

  @override
  _MealDetailState createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  final TextEditingController _mealNameController = new TextEditingController();

  @override
  void initState() {
    _mealNameController.text = widget.meal != null ? widget.meal.name : '';
    super.initState();
  }

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
                _mealName(),
                _food(),
                _mealButtons(context)
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
        label: widget.meal != null ? 'Save' : 'Create meal');
  }

  CardSection _mealButtons(BuildContext context) {
    final mealsBloc = MealsProvider.of(context);

    return CardSection(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              IconButton(
                onPressed: () {
                  mealsBloc.mealAddition.add(widget.meal != null
                      ? widget.meal
                      : Meal(_mealNameController.text));
                  Navigator.pop(context);
                },
                icon: Icon(Icons.check),
                color: Color(0xFF39a1e7),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
            ]),
            IconButton(
                onPressed: () {
                  if (widget.meal != null) {
                    mealsBloc.mealRemoval.add(widget.meal);
                  }
                  Navigator.pop(context);
                },
                icon: Icon(Icons.delete),
                color: Colors.red),
          ]),
      showBottomBorder: false,
    );
  }

  CardSection _mealName() {
    return CardSection(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Meal name',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
              child: TextField(
                  controller: _mealNameController,
                  decoration: InputDecoration(
                      hintText: 'e.g. English Breakfast',
                      hintStyle: TextStyle(fontSize: 16.0),
                      border: OutlineInputBorder())),
            ),
          ]),
      showBottomBorder: true,
    );
  }

  CardSection _food() {
    return CardSection(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text('Food'), _btnAddFood(context)],
      ),
      showBottomBorder: true,
    );
  }

  ActionButton _btnAddFood(BuildContext context) {
    return ActionButton(text: '+ ADD FOOD', fn: () {});
  }
}
