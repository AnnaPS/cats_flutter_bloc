import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_bloc.dart';
import 'package:catsapp/ui/random_cat/pages/random_cat_layout.dart';
import 'package:catsapp/repository/cat_repository.dart';
import 'package:catsapp/repository/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomCatPage extends StatelessWidget {
  const RandomCatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CatRepository(service: CatService()),
      child: BlocProvider(
        create: (context) => RandomCatBloc(
          catRepository: context.read<CatRepository>(),
        )..add(SearchRandomCat()),
        child: const RandomCatLayout(),
      ),
    );
  }
}
