import 'random_cat_event.dart';
import 'random_cat_state.dart';
import '../../../../repository/cat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomCatBloc extends Bloc<RandomCatEvent, RandomCatState> {
  RandomCatBloc({required this.catRepository}) : super(RandomCatInitState()) {
    on<SearchRandomCat>((event, emit) => _mapSearchEventToState(event, emit));
  }

  final CatRepository catRepository;
  void _mapSearchEventToState(
      SearchRandomCat event, Emitter<RandomCatState> emit) async {
    try {
      emit(RandomCatLoadState());
      final cat = await catRepository.search();
      if ((cat.breeds == null || cat.breeds!.isEmpty)) {
        emit(RandomCatEmptyBreedsState());
      } else {
        emit(state.copyWith(cat: cat));
      }
    } catch (error) {
      emit(RandomCatStateError(message: error.toString()));
    }
  }
}
