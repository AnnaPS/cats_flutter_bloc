import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_bloc.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_event.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_state.dart';
import 'package:catsapp/ui/random_cat/widgets/cat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomCatLayout extends StatelessWidget {
  const RandomCatLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomCatBloc, RandomCatState>(
      builder: (context, state) {
        if (state is RandomCatStateError) {
          print('error: ----> ${state.message}');
          return Center(
            child: Text(state.message),
          );
        } else if (state is RandomCatState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: CatCard(
                  key: const Key('cat_card'),
                  title: state.cat?.breeds?.first.name ?? 'No info',
                  origin: state.cat?.breeds?.first.origin ?? 'No info',
                  weight:
                      state.cat?.breeds?.first.weight?.imperial ?? 'No info',
                  description:
                      state.cat?.breeds?.first.description ?? 'No info',
                  catPhoto: state.cat?.url ??
                      'https://clinicadentalarias.com/wp-content/uploads/2016/10/orionthemes-placeholder-image.jpg',
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 18.0, bottom: 8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    key: const Key('fab_next_cat'),
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
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
