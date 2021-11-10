import '../../../utils/const_keys_app.dart';
import 'package:flutter/material.dart';

class FailureRandomCatView extends StatelessWidget {
  const FailureRandomCatView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key(ConstWidgetKeysApp.RandomCatFailure),
      child: Text('Something was wrong'),
    );
  }
}
