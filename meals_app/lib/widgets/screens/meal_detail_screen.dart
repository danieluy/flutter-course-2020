import 'package:flutter/material.dart';
import '../../models/Meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const ROUTE_NAME = '/meal-detail';
  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle('Ingredients'),
                  ...meal.ingredients
                      .map((ingredient) => Column(
                            children: [
                              ListTile(
                                title: Text(ingredient),
                                visualDensity: VisualDensity.compact,
                              ),
                              Divider(),
                            ],
                          ))
                      .toList(),
                  const SectionTitle('Steps'),
                  ...meal.steps
                      .map(
                        (step) => Column(
                          children: [
                            ListTile(
                              title: Text(step),
                              trailing: Checkbox(
                                value: false,
                                onChanged: (newValue) {},
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        tooltip: 'Delete and go back',
        onPressed: () {
          Navigator.of(context).pop(meal);
        },
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6.copyWith(height: 2),
    );
  }
}
