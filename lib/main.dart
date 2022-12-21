import 'package:flutter/material.dart';

import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/tabs':(context) => const TabsScreen(),
        CategoryMealsScreen.routeName: (context) => const CategoryMealsScreen(),
        MealDetailScreen.routeName:(context) => const MealDetailScreen()
      },

      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: ((context) => const CategoriesScreen()));
      // },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const CategoriesScreen());
      },
      // fallback route
    );
  }
}
