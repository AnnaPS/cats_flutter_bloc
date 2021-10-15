import 'package:catsapp/repository/model/cat.dart';
import 'package:flutter/material.dart';

import '../../../catapp_theme.dart';

class Card1 extends StatelessWidget {
  const Card1({Key? key, required this.cat}) : super(key: key);

  final String category = 'Editor\'s Choice';
  final String title = 'The Art of Dough';
  final String description = 'Learn to make the perfect bread.';
  final String chef = 'Ana Polo';
  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Text(
            category,
            style: CatAppTheme.darkTextTheme.bodyText1,
          ),
          Positioned(
            child: Text(
              title,
              style: CatAppTheme.darkTextTheme.headline2,
            ),
            top: 20,
          ),
          Positioned(
            child: Text(
              description,
              style: CatAppTheme.darkTextTheme.bodyText1,
            ),
            bottom: 30,
            right: 0,
          ),
          Positioned(
            child: Text(
              chef,
              style: CatAppTheme.darkTextTheme.bodyText1,
            ),
            bottom: 10,
            right: 0,
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints.expand(
        width: 350,
        height: 450,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(cat.url ?? ''),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }
}
