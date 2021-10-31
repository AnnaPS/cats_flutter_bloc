import 'package:bloc_test/bloc_test.dart';
import 'package:catsapp/repository/cat_repository.dart' as catRepository;
import 'package:catsapp/repository/model/breed.dart';
import 'package:catsapp/repository/model/cat.dart' as cat;
import 'package:catsapp/repository/model/result_error.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_bloc.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_event.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements catRepository.CatRepository {}

class MockCat extends Mock implements cat.Cat {}

class MockCatCopyWith extends Mock implements cat.Cat {}

void main() {
  group('RandomCatBloc', () {
    late catRepository.CatRepository catRepositoryMock;
    late cat.Cat catMock;
    late cat.Cat catMockCopyWith;
    late RandomCatState randomCatState;

    setUp(() {
      catRepositoryMock = MockRepository();
      catMock = MockCat();
      catMockCopyWith = MockCatCopyWith();
      randomCatState = RandomCatState(cat: catMock);
    });

    test('initial state of the bloc is [RandomCatInitState]', () {
      expect(RandomCatBloc(catRepository: catRepositoryMock).state,
          RandomCatInitState());
    });

    blocTest<RandomCatBloc, RandomCatState>(
      'emits [RandomCatLoadState, RandomCatEmptyBreedsState] '
      'state when cat.breeds are empty',
      setUp: () {
        when(() => catMock.breeds).thenReturn([]);
        when(() => catRepositoryMock.search()).thenAnswer((_) async => catMock);
      },
      build: () => RandomCatBloc(catRepository: catRepositoryMock),
      act: (bloc) => bloc.add(SearchRandomCat()),
      expect: () => [RandomCatLoadState(), RandomCatEmptyBreedsState()],
    );

    blocTest<RandomCatBloc, RandomCatState>(
      'emits [RandomCatLoadState, RandomCatEmptyBreedsState] '
      'state when cat.breeds are null',
      setUp: () {
        when(() => catMock.breeds).thenReturn(null);
        when(() => catRepositoryMock.search()).thenAnswer((_) async => catMock);
      },
      build: () => RandomCatBloc(catRepository: catRepositoryMock),
      act: (bloc) => bloc.add(SearchRandomCat()),
      expect: () => [RandomCatLoadState(), RandomCatEmptyBreedsState()],
    );

    blocTest<RandomCatBloc, RandomCatState>(
      'emits [RandomCatLoadState, RandomCatState.copyWith]'
      ' with a copyWith of other cat'
      'state for successful',
      setUp: () {
        when(() => catMockCopyWith.breeds)
            .thenReturn(List.generate(1, (index) => const Breed(id: '1')));
        when(() => catRepositoryMock.search())
            .thenAnswer((_) async => catMockCopyWith);
      },
      build: () => RandomCatBloc(catRepository: catRepositoryMock),
      act: (bloc) => bloc.add(SearchRandomCat()),
      expect: () =>
          [RandomCatLoadState(), randomCatState.copyWith(cat: catMockCopyWith)],
    );

    blocTest<RandomCatBloc, RandomCatState>(
      'emits [RandomCatLoadState, RandomCatState] with a default cat'
      'state for successful',
      setUp: () {
        when(() => catMock.breeds)
            .thenReturn(List.generate(1, (index) => const Breed(id: '1')));
        when(() => catRepositoryMock.search()).thenAnswer((_) async => catMock);
      },
      build: () => RandomCatBloc(catRepository: catRepositoryMock),
      act: (bloc) => bloc.add(SearchRandomCat()),
      expect: () => [RandomCatLoadState(), randomCatState.copyWith()],
    );

    blocTest<RandomCatBloc, RandomCatState>(
      'emits [RandomCatLoadState, RandomCatStateError] when unsuccessful',
      setUp: () {
        when(() => catRepositoryMock.search())
            .thenThrow((_) async => ErrorSearchingCat());
      },
      build: () => RandomCatBloc(catRepository: catRepositoryMock),
      act: (bloc) => bloc.add(SearchRandomCat()),
      expect: () =>
          [RandomCatLoadState(), const RandomCatStateError(message: 'error')],
    );
  });
}
