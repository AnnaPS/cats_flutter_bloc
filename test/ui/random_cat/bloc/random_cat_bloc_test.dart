import 'package:bloc_test/bloc_test.dart';
import 'package:catsapp/repository/cat_repository.dart' as catRespository;
import 'package:catsapp/repository/model/cat.dart' as cat;
import 'package:catsapp/repository/model/result_error.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_bloc.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_event.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements catRespository.CatRepository {}

class MockCat extends Mock implements cat.Cat {}

void main() {
  group('RandomCatBloc', () {
    late RandomCatBloc catBloc;
    late catRespository.CatRepository catRepositoryMock;
    late cat.Cat catMock;

    setUp(() {
      catRepositoryMock = MockRepository();
      catBloc = RandomCatBloc(catRepository: catRepositoryMock);
      catMock = MockCat();
    });

    test('initial state of the bloc is [RandomCatInitState]', () {
      expect(catBloc.state, RandomCatInitState());
    });

    blocTest<RandomCatBloc, RandomCatState>(
      'emits [RandomCatLoadState, RandomCatState] '
      'state for successful search',
      setUp: () {
        when(() => catRepositoryMock.search()).thenAnswer(
          (_) async => catMock,
        );
      },
      build: () => catBloc,
      act: (bloc) => bloc.add(SearchRandomCat()),
      verify: (_) => verify(() => catRepositoryMock.search()),
    );

    blocTest<RandomCatBloc, RandomCatState>(
      'emits [RandomCatLoadState, RandomCatStateError] when unsuccessful',
      setUp: () {
        when(() => catRepositoryMock.search())
            .thenThrow((_) async => const ResultError(message: 'error'));
      },
      build: () => catBloc,
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
        build: () => catBloc,
        act: (bloc) => bloc.add(SearchRandomCat()),
        expect: () => [RandomCatLoadState(), RandomCatEmptyBreedsState()]);

    tearDown(() {
      catBloc.close();
    });
  });
}
