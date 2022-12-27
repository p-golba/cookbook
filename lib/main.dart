import 'package:flutter/material.dart';

import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './models/meal.dart';
import './dummy_data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false
  };

  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = dummyMeals.where((element) {
        if (_filters['gluten']! && !element.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !element.isLactoseFree) {
          return false;
        }
        if (_filters['vegetarian']! && !element.isVegetarian) {
          return false;
        }
        if (_filters['vegan']! && !element.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId){
    final existingIndex = _favouriteMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0){
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      _favouriteMeals.add(dummyMeals.firstWhere((element) => element.id == mealId));
    }
  }

  bool _isMealFavourite(String id){
    return _favouriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
        ).copyWith(
          secondary: Colors.blue.shade300,
        ),
        canvasColor: Colors.blueGrey.shade200,
        fontFamily: 'Raleway',
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          headline6: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const CategoriesScreen(),
      initialRoute: '/tabs',
      routes: {
        '/tabs': (context) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FiltersScreen.routeName: (context) => FiltersScreen(_setFilters, _filters)
      },

      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: ((context) => const CategoriesScreen()));
      // },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => const CategoriesScreen());
      },
      // fallback route
    );
  }
}
