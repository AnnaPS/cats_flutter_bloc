import 'ui/utils/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'catapp_theme.dart';
import 'ui/home/home.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  runApp(const CatApp());
}

class CatApp extends StatelessWidget {
  const CatApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = CatAppTheme.dark();
    return MaterialApp(
      theme: theme,
      title: 'Cats',
      home: const Home(),
    );
  }
}
