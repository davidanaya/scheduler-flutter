import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

import 'package:scheduler_flutter/src/models/meal.dart';
import 'package:scheduler_flutter/src/services/meals_service.dart';

class MealsSqlite extends MealsService {
  // at some point this class could evolve into a SQliteHelper and be used
  // in different domains
  static Database _db;

  static String tableMeals = 'meals';
  static String mealsId = 'id';
  static String mealsName = 'name';
  static String mealsFood = 'food';

  final _meals$ = BehaviorSubject<List<Meal>>(seedValue: []);

  MealsSqlite() {
    _open().catchError(_handleError);
  }

  void dispose() {
    _meals$.close();
  }

  Future<void> _open() async {
    io.Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = join(appDocDir.path, "meals.db");
    _db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onOpen: _onOpen);
  }

  void _onCreate(Database db, int version) async {
    db.execute('''
      CREATE TABLE $tableMeals(
        $mealsId integer primary key autoincrement,
        $mealsName text,
        $mealsFood text)
      ''');
  }

  void _onOpen(Database db) async {
    _nextOnMeals(db);
  }

  void _nextOnMeals(Database db) async {
    var meals = await _getMeals(db);
    _meals$.add(meals);
  }

  Future<List<Meal>> _getMeals(Database db) async {
    List<Map> list = await db.rawQuery('SELECT * FROM $tableMeals');
    List<Meal> meals = List();
    for (int i = 0; i < list.length; i++) {
      meals.add(Meal.fromSqliteMap(list[i]));
    }
    return meals;
  }

  @override
  Future<void> delete(Meal meal) async {
    var delete = await _db
        .delete(tableMeals, where: '$mealsId = ?', whereArgs: [meal.id]);
    _nextOnMeals(_db);
    return delete;
  }

  @override
  Stream<List<Meal>> get meals$ => _meals$.stream;

  @override
  Future<void> save(Meal meal) async {
    var mealMap = meal.toSqliteMap();
    var update = meal.isUpdate()
        ? await _update(mealMap, meal.id)
        : await _insert(mealMap);

    _nextOnMeals(_db);

    return update;
  }

  Future<void> _insert(Map<String, dynamic> mealMap) {
    return _db.insert(tableMeals, mealMap);
  }

  Future<void> _update(Map<String, dynamic> mealMap, String id) {
    return _db
        .update(tableMeals, mealMap, where: '$mealsId = ?', whereArgs: [id]);
  }

  _handleError(e) {
    print(e);
  }
}
