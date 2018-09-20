import 'package:flutter/material.dart';

import 'package:scheduler_flutter/src/models/meal.dart';
import 'package:scheduler_flutter/src/shared/meals_bloc.dart';
import 'package:scheduler_flutter/src/shared/meals_provider.dart';
import 'package:scheduler_flutter/src/shared/widgets/action_button.dart';
import 'package:scheduler_flutter/src/shared/widgets/card-section.dart';

class MealForm extends StatefulWidget {
  final Meal meal;

  MealForm(this.meal);

  @override
  _MealFormState createState() => _MealFormState();
}

class _MealFormState extends State<MealForm> {
  final TextEditingController _nameController = new TextEditingController();
  final List<TextEditingController> _foodControllers = [];

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.meal.name;
    widget.meal.food.forEach(_addFoodController);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _foodControllers.forEach(_disposeController);
    super.dispose();
  }

  _disposeController(TextEditingController controller) {
    controller.dispose();
  }

  _addFoodController(String text) {
    _foodControllers
        .add(TextEditingController.fromValue(TextEditingValue(text: text)));
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            children: <Widget>[_mealName(), _food(), _formButtons(context)]));
  }

  CardSection _mealName() {
    return CardSection(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
          child: TextFormField(
            validator: (value) =>
                value.isEmpty ? 'Meal name can\'t be empty!' : null,
            controller: _nameController,
            decoration: _textFieldDecoration(
                label: 'Meal name', hint: 'e.g. English Breakfast'),
          )),
      showBottomBorder: true,
    );
  }

  CardSection _food() {
    return CardSection(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text('Food'), _btnAddFood(context)],
          ),
          _foodList()
        ],
      ),
      showBottomBorder: true,
    );
  }

  ActionButton _btnAddFood(BuildContext context) {
    return ActionButton(
        text: '+ ADD FOOD',
        fn: () {
          if (_foodControllers.length == Meal.maxFoodIngredients) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Sorry, only ${Meal.maxFoodIngredients} ingredients allowed',
                  textAlign: TextAlign.center),
            ));
          } else {
            setState(() {
              _addFoodController('');
            });
          }
        });
  }

  Column _foodList() {
    return Column(
        children: _foodControllers
            .map((controller) => Padding(
                  padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: TextFormField(
                          controller: controller,
                          decoration: _textFieldDecoration(hint: 'e.g. Eggs'),
                          onSaved: (String value) {
                            widget.meal.addFood(value);
                          }),
                    ),
                    IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _foodControllers.remove(controller);
                            widget.meal.removeFood(controller.text);
                            // getting an exception when trying to dispose
                            // A TextEditingController was used after being disposed.
                            // controller.dispose();
                          });
                        }),
                  ]),
                ))
            .toList());
  }

  InputDecoration _textFieldDecoration({String label, String hint}) {
    return InputDecoration(
        contentPadding: EdgeInsets.all(12.0),
        labelText: label,
        labelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14.0),
        border: OutlineInputBorder());
  }

  CardSection _formButtons(BuildContext context) {
    final mealsBloc = MealsProvider.of(context);

    return CardSection(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              IconButton(
                onPressed: () {
                  _saveMeal(context);
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
                  if (!widget.meal.isEmpty()) {
                    mealsBloc.removal.add(widget.meal);
                  }
                  Navigator.pop(context);
                },
                icon: Icon(Icons.delete),
                color: Colors.red),
          ]),
      showBottomBorder: false,
    );
  }

  _saveMeal(BuildContext context) {
    final mealsBloc = MealsProvider.of(context);

    if (this._formKey.currentState.validate()) {
      // update food in current meal
      _formKey.currentState.save();

      var meal = Meal.clone(widget.meal, _nameController.text);
      widget.meal.isEmpty()
          ? mealsBloc.addition.add(meal)
          : mealsBloc.update.add(MealUpdater(widget.meal, meal));
    }

    Navigator.pop(context);
  }
}
