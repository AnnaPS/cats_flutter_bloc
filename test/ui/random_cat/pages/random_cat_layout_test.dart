import 'package:bloc_test/bloc_test.dart';
import 'package:catsapp/repository/cat_repository.dart';
import 'package:catsapp/repository/model/cat.dart';
import 'package:catsapp/repository/service.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_bloc.dart';

import 'package:catsapp/ui/random_cat/pages/random_cat_layout.dart';
import 'package:catsapp/ui/random_cat/pages/random_cat_page.dart';
import 'package:catsapp/ui/random_cat/widgets/cat_card.dart';
import 'package:catsapp/utils/const_keys_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockRandomCatBloc extends MockBloc<RandomCatEvent, RandomCatState>
    implements RandomCatBloc {}

class MockRandomCatState extends Fake implements RandomCatState {}

class MockRandomCatEvent extends Fake implements RandomCatEvent {}

void main() {
  late CatRepository catRepository;
  late Widget randomCatView;
  late MockRandomCatBloc blocCat;

  setUp(() {
    catRepository = CatRepository(service: CatService());

    registerFallbackValue<RandomCatEvent>(RandomCatEvent());
    registerFallbackValue<MockRandomCatState>(MockRandomCatState());

    blocCat = MockRandomCatBloc();

    randomCatView = BlocProvider<RandomCatBloc>(
      lazy: false,
      create: (_) => blocCat,
      child: const MaterialApp(
        home: RandomCatLayout(),
      ),
    );
  });

  group('RandomCatPage states ', () {
    testWidgets(
        'render RandomCatLayout when state is [RandomCatStatus.failure]',
        (tester) async {
      when(() => blocCat.state)
          .thenReturn(const RandomCatState(status: RandomCatStatus.failure));
      await mockNetworkImagesFor(() => tester.pumpWidget(randomCatView));
      expect(find.text('error'), findsOneWidget);
    });

    testWidgets(
        'render RandomCatLayout when state is [RandomCatStatus.loading]',
        (tester) async {
      when(() => blocCat.state)
          .thenReturn(const RandomCatState(status: RandomCatStatus.loading));
      await mockNetworkImagesFor(() => tester.pumpWidget(randomCatView));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'render RandomCatLayout when state is [RandomCatStatus.success]',
        (tester) async {
      when(() => blocCat.state)
          .thenReturn(const RandomCatState(status: RandomCatStatus.success));
      await mockNetworkImagesFor(() => tester.pumpWidget(randomCatView));
      expect(find.byType(CatCard), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets(
        'render RandomCatLayout when state is [RandomCatStatus.initial]',
        (tester) async {
      when(() => blocCat.state)
          .thenReturn(const RandomCatState(status: RandomCatStatus.initial));
      await mockNetworkImagesFor(() => tester.pumpWidget(randomCatView));
      expect(find.text('No information available'), findsOneWidget);
    });
  });

  group('tap FAB', () {
    testWidgets('call to bloc when click on FAB', (tester) async {
      when(() => blocCat.state)
          .thenReturn(const RandomCatState(status: RandomCatStatus.success));
      await mockNetworkImagesFor(() => tester.pumpWidget(randomCatView));
      expect(find.byType(FloatingActionButton), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      verify(() => blocCat.add(SearchRandomCat())).called(1);
    });
  });

  group('Call again to SearchRandomCat on BlocListener ', () {
    const cat = Cat(id: '1', breeds: [], width: 1, height: 1, url: 'www');
    testWidgets('Call again to SearchRandomCat when breeds is empty',
        (tester) async {
      whenListen(
        blocCat,
        Stream<RandomCatState>.fromIterable(
          [
            const RandomCatState(),
            const RandomCatState(status: RandomCatStatus.emptyBreeds, cat: cat)
          ],
        ),
      );
      when(() => blocCat.state).thenReturn(
          const RandomCatState(status: RandomCatStatus.emptyBreeds, cat: cat));
      await mockNetworkImagesFor(() => tester.pumpWidget(randomCatView));

      verify(() => blocCat.add(SearchRandomCat())).called(1);
    });
  });
}
