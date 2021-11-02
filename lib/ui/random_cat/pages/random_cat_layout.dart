import 'package:catsapp/repository/model/cat.dart';

import 'bloc/random_cat_bloc.dart';
import 'bloc/random_cat_event.dart';
import 'bloc/random_cat_state.dart';
import '../widgets/cat_card.dart';
import '../../../utils/const_keys_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomCatLayout extends StatelessWidget {
  const RandomCatLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RandomCatBloc, RandomCatState>(
      listener: (context, state) {
        if (state is RandomCatEmptyBreedsState) {
          context.read<RandomCatBloc>().add(SearchRandomCat());
        }
      },
      builder: (context, state) {
        if (state is RandomCatStateError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is RandomCatLoadState) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        } else if (state is RandomCatState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: CatCard(
                  key: const Key(ConstWidgetKeysApp.RandomCatCardKey),
                  cat: state.cat ?? const Cat(),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 18.0, bottom: 8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    key: const Key(ConstWidgetKeysApp.RandomCatFabButtonKey),
                    onPressed: () async {
                      context.read<RandomCatBloc>().add(SearchRandomCat());
                    },
                    child: const Icon(Icons.refresh),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: Text('No information available'),
          );
        }
      },
    );
  }
}
