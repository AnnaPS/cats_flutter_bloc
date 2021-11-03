import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../random_cat.dart';

part 'random_cat_state.dart';
part 'random_cat_event.dart';

class RandomCatBloc extends Bloc<RandomCatEvent, RandomCatState> {
  RandomCatBloc({required this.catRepository}) : super(const RandomCatState()) {
    on<SearchRandomCat>((event, emit) => _mapSearchEventToState(event, emit));
  }

  final CatRepository catRepository;
  void _mapSearchEventToState(
      SearchRandomCat event, Emitter<RandomCatState> emit) async {
    try {
      emit(state.copyWith(status: RandomCatStatus.loading));
      final cat = await catRepository.search();
      if (cat.breeds == null || cat.breeds!.isEmpty) {
        emit(state.copyWith(status: RandomCatStatus.emptyBreeds));
      } else {
        emit(state.copyWith(cat: cat, status: RandomCatStatus.success));
      }
    } catch (_) {
      emit(state.copyWith(status: RandomCatStatus.failure));
    }
  }
}
