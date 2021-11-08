import 'package:bloc_test/bloc_test.dart';
import 'package:catsapp/repository/service.dart';
import 'package:catsapp/ui/random_cat/random_cat.dart';
import 'package:catsapp/repository/cat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockRandomCatBloc extends MockBloc<RandomCatEvent, RandomCatState>
    implements RandomCatBloc {}

class FakeRandomCatState extends Fake implements RandomCatState {}

class FakeRandomCatEvent extends Fake implements RandomCatEvent {}

void main() {
  late CatRepository catRepository;
  late MockRandomCatBloc blocCat;

  setUpAll(() {
    registerFallbackValue(RandomCatEvent());
    registerFallbackValue(FakeRandomCatState());
  });

  setUp(() {
    catRepository = CatRepository(service: CatService());
    blocCat = MockRandomCatBloc();
  });

  group('RandomCatPage ', () {
    testWidgets('renders RandomCatPage', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          RepositoryProvider(
            create: (_) => catRepository,
            child: BlocProvider<RandomCatBloc>(
              lazy: false,
              create: (_) => blocCat,
              child: const MaterialApp(
                home: RandomCatPage(),
              ),
            ),
          ),
        ),
      );
      expect(find.byType(RandomCatPage), findsOneWidget);
    });
  });
}
