import 'package:flutter/material.dart';

import '../../../catapp_theme.dart';

class CatCard extends StatelessWidget {
  const CatCard(
      {Key? key,
      required this.catPhoto,
      required this.title,
      required this.origin,
      required this.description,
      required this.weight})
      : super(key: key);

  final String origin;
  final String title;
  final String description;
  final String weight;
  final String catPhoto;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Text(
            origin,
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
            child: SizedBox(
              width: 260,
              child: Text(
                description,
                style: CatAppTheme.darkTextTheme.bodyText1,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
            ),
            bottom: 40,
            right: 0,
          ),
          Positioned(
            child: Text(
              weight,
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
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
          image: NetworkImage(catPhoto),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }
}
