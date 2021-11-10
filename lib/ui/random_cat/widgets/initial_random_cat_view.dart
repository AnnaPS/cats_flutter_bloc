import '../../../utils/const_keys_app.dart';
import 'package:flutter/material.dart';

class InitialRandomCatView extends StatelessWidget {
  const InitialRandomCatView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key(ConstWidgetKeysApp.RandomCatInitial),
      child: Text('No information available'),
    );
  }
}
