import '../../utils/const_keys_app.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key(ConstWidgetKeysApp.CatLoading),
      child: CircularProgressIndicator(color: Colors.green),
    );
  }
}
