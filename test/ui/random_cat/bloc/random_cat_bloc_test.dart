import 'package:bloc_test/bloc_test.dart';
import 'package:catsapp/repository/cat_repository.dart' as catRepository;
import 'package:catsapp/repository/model/cat.dart' as cat;
import 'package:catsapp/repository/model/result_error.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_bloc.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_event.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements catRepository.CatRepository {}

class MockCat extends Mock implements cat.Cat {}

void main() {
  group('RandomCatBloc', () {
    late catRepository.CatRepository catRepositoryMock;
    late cat.Cat catMock;

    setUp(() {
      catRepositoryMock = MockRepository();
      catMock = MockCat();
    });

    test('initial state of the bloc is [RandomCatInitState]', () {
      expect(RandomCatBloc(catRepository: catRepositoryMock).state,
          RandomCatInitState());
    });

    blocTest<RandomCatBloc, RandomCatState>(
      'emits [RandomCatLoadState, RandomCatState] '
      'state for successful search',
      setUp: () {
        when(() => catRepositoryMock.search()).thenAnswer(
          (_) async => catMock,
        );
      },
      build: () => RandomCatBloc(catRepository: catRepositoryMock),
      act: (bloc) => bloc.add(SearchRandomCat()),
      expect: () => [
        RandomCatLoadState(),
        catMock.breeds != null
            ? RandomCatBloc(catRepository: catRepositoryMock)
                .state
                .copyWith(cat: catMock)
            : RandomCatEmptyBreedsState()
      ],
    );

    blocTest<RandomCatBloc, RandomCatState>(
      'emits [RandomCatLoadState, RandomCatStateError] when unsuccessful',
      setUp: () {
        when(() => catRepositoryMock.search())
            .thenThrow((_) async => const ResultError(message: 'error'));
      },
      build: () => RandomCatBloc(catRepository: catRepositoryMock),
      act: (bloc) => bloc.add(SearchRandomCat()),
      expect: () =>
          [RandomCatLoadState(), const RandomCatStateError(message: 'error')],
    );

    blocTest<RandomCatBloc, RandomCatState>(
        'emits [RandomCatLoadState, RandomCatEmptyBreedsState] '
        'state when cat.breeds are null or empty',
        setUp: () {
          when(() => catMock.breeds).thenAnswer((_) => catMock.breeds = []);
          when(() => catMock.breeds).thenAnswer((_) => catMock.breeds = null);
          when(() => catRepositoryMock.search())
              .thenAnswer((_) async => catMock);
        },
        build: () => RandomCatBloc(catRepository: catRepositoryMock),
        act: (bloc) => bloc.add(SearchRandomCat()),
        expect: () => [RandomCatLoadState(), RandomCatEmptyBreedsState()]);
  });
}
