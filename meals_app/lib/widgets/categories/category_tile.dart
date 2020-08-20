import 'package:flutter/material.dart';
import '../screens/categoy_meals_screen.dart';
import '../../models/Category.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  CategoryTile(this.category);

  void _selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      CategoryMealsScreen.ROUTE_NAME,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => _selectCategory(context),
      splashColor: Colors.black,
      borderRadius: borderRadius,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          category.title,
          style: theme.textTheme.headline6.copyWith(
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [category.color.withOpacity(0.7), category.color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
