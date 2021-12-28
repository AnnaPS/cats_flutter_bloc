import 'package:catsapp/repository/model/cat.dart';
import 'package:catsapp/utils/const_keys_app.dart';
import 'package:flutter/material.dart';

import '../../../catapp_theme.dart';

class CatCard extends StatelessWidget {
  const CatCard({
    Key? key,
    required this.cat,
  }) : super(key: key);

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key(ConstWidgetKeysApp.RandomCatCardImage),
      child: Stack(
        children: [
          Text(
            cat.breeds?.first.origin ?? 'No info',
            style: CatAppTheme.darkTextTheme.bodyText1,
          ),
          Positioned(
            child: Text(
              cat.breeds?.first.name ?? 'No info',
              key: const Key(ConstWidgetKeysApp.RandomCatCardTitle),
              style: CatAppTheme.darkTextTheme.headline2,
            ),
            top: 20,
          ),
          Positioned(
            child: SizedBox(
              width: 260,
              child: Text(
                cat.breeds?.first.description ?? 'No info',
                key: const Key(ConstWidgetKeysApp.RandomCatCardDescription),
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
              cat.breeds?.first.weight?.metric ?? 'No info',
              key: const Key(ConstWidgetKeysApp.RandomCatCardWeight),
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
        color: Colors.grey[800],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
          image: NetworkImage(cat.url ??
              'https://clinicadentalarias.com/wp-content/uploads/2016/10/orionthemes-placeholder-image.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }
}
