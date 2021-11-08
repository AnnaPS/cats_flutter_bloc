import 'package:bloc_test/bloc_test.dart';
import 'package:catsapp/repository/cat_repository.dart' as catRepository;
import 'package:catsapp/repository/model/cat.dart' as cat;
import 'package:catsapp/ui/random_cat/random_cat.dart';
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

    test('initial state of the bloc is [RandomCatStatus.initial]', () {
      expect(RandomCatBloc(catRepository: catRepositoryMock).state,
          const RandomCatState().copyWith());
    });

    blocTest<RandomCatBloc, RandomCatState>(
      'emits [RandomCatStatus.loading, RandomCatStatus.emptyBreeds] '
      'state when cat.breeds are empty',
      setUp: () {
        when(() => catMock.breeds).thenReturn([]);
        when(() => catRepositoryMock.search()).thenAnswer((_) async => catMock);
      },
      build: () => RandomCatBloc(catRepository: catRepositoryMock),
      act: (bloc) => bloc.add(SearchRandomCat()),
      expect: () => <RandomCatState>[
        const RandomCatState(status: RandomCatStatus.loading),
        const RandomCatState(status: RandomCatStatus.emptyBreeds),
      ],
    );

    blocTest<RandomCatBloc, RandomCatState>(
      'emits [RandomCatStatus.loading, RandomCatStatus.emptyBreeds] '
      'state when cat.breeds are null',
      setUp: () {
        when(() => catMock.breeds).thenReturn(null);
        when(() => catRepositoryMock.search()).thenAnswer((_) async => catMock);
      },
      build: () => RandomCatBloc(catRepository: catRepositoryMock),
      act: (bloc) => bloc.add(SearchRandomCat()),
      expect: () => [
        const RandomCatState(status: RandomCatStatus.loading),
        const RandomCatState(status: RandomCatStatus.emptyBreeds)
      ],
    );

    blocTest<RandomCatBloc, RandomCatState>(
      'emits [RandomCatStatus.loading, RandomCatStatus.success]'
      ' with a copyWith of other cat'
      'state for successful',
      setUp: () {
        when(() => catMock.breeds).thenReturn(
          List.generate(
            1,
            (index) => const Breed(id: '1'),
          ),
        );
        when(() => catRepositoryMock.search()).thenAnswer((_) async => catMock);
      },
      build: () => RandomCatBloc(catRepository: catRepositoryMock),
      act: (bloc) => bloc.add(SearchRandomCat()),
      expect: () => [
        const RandomCatState(status: RandomCatStatus.loading),
        RandomCatBloc(catRepository: catRepositoryMock)
            .state
            .copyWith(cat: catMock, status: RandomCatStatus.success)
      ],
    );

    blocTest<RandomCatBloc, RandomCatState>(
      'emits [RandomCatStatus.loading, RandomCatStatus.failure] '
      'when unsuccessful',
      setUp: () {
        when(() => catRepositoryMock.search()).thenThrow(ErrorSearchingCat());
      },
      build: () => RandomCatBloc(catRepository: catRepositoryMock),
      act: (bloc) => bloc.add(SearchRandomCat()),
      expect: () => <RandomCatState>[
        const RandomCatState(status: RandomCatStatus.loading),
        const RandomCatState(status: RandomCatStatus.failure)
      ],
    );
  });
}
