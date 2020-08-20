import 'package:flutter/material.dart';
import '../../models/Category.dart';
import '../../models/Filter.dart';
import '../../models/Meal.dart';
import '../../widgets/meals/meal_item.dart';

import '../../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const ROUTE_NAME = '/category-meals';
  final List<Filter> filters;

  CategoryMealsScreen({this.filters});

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  Category category;
  List<Meal> meals = [];
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    // Runs before build
    super.didChangeDependencies();
    if (!_initialized) {
      category = ModalRoute.of(context).settings.arguments as Category;
      meals = DUMMY_MEALS.where(
        (meal) {
          final idMatch = meal.categories.contains(category.id);
          return idMatch;
        },
      ).toList();
      _initialized = true;
    }
  }

  List<Meal> _applyFilters(List<Meal> meals) {
    final activeFilter = widget.filters.firstWhere(
      (filter) {
        return filter.state;
      },
      orElse: () => null,
    );
    if (activeFilter == null) {
      return meals;
    }
    return meals.where((meal) {
      switch (activeFilter.description) {
        case 'Gluten Free':
          return meal.isGlutenFree;
        case 'Vegetarian':
          return meal.isVegetarian;
        case 'Vegan':
          return meal.isVegan;
        case 'Lactose Free':
          return meal.isLactoseFree;
        default:
          throw Exception('Unhadled filter: ${activeFilter.description}');
      }
    }).toList();
  }

  String get title {
    if (category == null) {
      return 'Loading...';
    }
    return category.title;
  }

  void _removeMeal(Meal meal) {
    setState(() {
      meals.removeWhere((item) => item == meal);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> filteredMeals = _applyFilters(meals);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: filteredMeals.length,
        itemBuilder: (ctx, i) => MealItem(filteredMeals[i], _removeMeal),
      ),
    );
  }
}
