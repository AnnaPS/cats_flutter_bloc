import '../random_cat.dart';
import 'bloc/random_cat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomCatLayout extends StatelessWidget {
  const RandomCatLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RandomCatBloc, RandomCatState>(
      listener: (context, state) {
        if (state.status.isEmptyBreeds) {
          context.read<RandomCatBloc>().add(SearchRandomCat());
        }
      },
      builder: (context, state) {
        if (state.status.isFailure) {
          return const FailureRandomCatView();
        } else if (state.status.isInitial) {
          return const InitialRandomCatView();
        } else if (state.status.isLoading) {
          return const LoadingView();
        } else if (state.status.isSuccess) {
          return SuccessRandomCatView(
            cat: state.cat,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
