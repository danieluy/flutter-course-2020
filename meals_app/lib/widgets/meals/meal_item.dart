import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/screens/meal_detail_screen.dart';
import '../../models/Meal.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  final Function removeMeal;

  MealItem(this.meal, this.removeMeal);

  void _handleTap(BuildContext ctx) {
    Future onPop = Navigator.of(ctx).pushNamed(
      MealDetailScreen.ROUTE_NAME,
      arguments: meal,
    );
    onPop.then((meal) {
      if (meal != null) {
        removeMeal(meal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: InkWell(
        onTap: () => _handleTap(context),
        splashColor: Theme.of(context).primaryColor,
        borderRadius: borderRadius,
        child: Column(
          children: [
            Stack(
              children: [
                Banner(meal: meal),
                Title(meal.title),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DurationInfo(meal.duration),
                  ComplexityInfo(meal.complexity),
                  AffordabilityInfo(meal.affordability),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AffordabilityInfo extends StatelessWidget {
  final Affordability affordability;

  AffordabilityInfo(this.affordability);

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return ' Affordable';
      case Affordability.Pricey:
        return ' Pricey';
      case Affordability.Luxurious:
        return ' Luxurious';
      default:
        throw Exception('Unhandled Affordabiliy option.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.attach_money),
        Text(affordabilityText),
      ],
    );
  }
}

class ComplexityInfo extends StatelessWidget {
  final Complexity complexity;

  ComplexityInfo(this.complexity);

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return ' Simple';
      case Complexity.Challenging:
        return ' Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        throw Exception('Unhandled Complexity option.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.work),
        Text(complexityText),
      ],
    );
  }
}

class DurationInfo extends StatelessWidget {
  final int duration;

  DurationInfo(this.duration);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.schedule),
        Text(' $duration min'),
      ],
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({
    Key key,
    @required this.meal,
  }) : super(key: key);

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      child: Image.network(
        meal.imageUrl,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;

  const Title(this.title);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        color: Colors.black54,
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          softWrap: true,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
