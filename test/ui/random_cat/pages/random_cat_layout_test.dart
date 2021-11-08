import 'package:bloc_test/bloc_test.dart';
import 'package:catsapp/ui/random_cat/random_cat.dart';
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
  late MockRandomCatBloc blocCat;

  setUpAll(() {
    // Register the event and the state
    registerFallbackValue(FakeRandomCatEvent());
    registerFallbackValue(FakeRandomCatState());
  });

  setUp(() {
    blocCat = MockRandomCatBloc();
  });

  group('RandomCatPage states ', () {
    testWidgets(
        'render RandomCatLayout when state is [RandomCatStatus.failure]',
        (tester) async {
      when(() => blocCat.state).thenReturn(
        const RandomCatState(status: RandomCatStatus.failure),
      );
      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          BlocProvider<RandomCatBloc>(
            lazy: false,
            create: (_) => blocCat,
            child: const MaterialApp(
              home: RandomCatLayout(),
            ),
          ),
        ),
      );
      expect(find.text('error'), findsOneWidget);
    });

    testWidgets(
        'render RandomCatLayout when state is [RandomCatStatus.loading]',
        (tester) async {
      when(() => blocCat.state).thenReturn(
        const RandomCatState(status: RandomCatStatus.loading),
      );
      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          BlocProvider<RandomCatBloc>(
            lazy: false,
            create: (_) => blocCat,
            child: const MaterialApp(
              home: RandomCatLayout(),
            ),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'render RandomCatLayout when state is [RandomCatStatus.success]',
        (tester) async {
      when(() => blocCat.state).thenReturn(
        const RandomCatState(status: RandomCatStatus.success),
      );
      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          BlocProvider<RandomCatBloc>(
            lazy: false,
            create: (_) => blocCat,
            child: const MaterialApp(
              home: RandomCatLayout(),
            ),
          ),
        ),
      );
      expect(find.byType(CatCard), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets(
        'render RandomCatLayout when state is [RandomCatStatus.initial]',
        (tester) async {
      when(() => blocCat.state).thenReturn(
        const RandomCatState(status: RandomCatStatus.initial),
      );
      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          BlocProvider<RandomCatBloc>(
            lazy: false,
            create: (_) => blocCat,
            child: const MaterialApp(
              home: RandomCatLayout(),
            ),
          ),
        ),
      );
      expect(find.text('No information available'), findsOneWidget);
    });
  });

  group('tap FAB', () {
    testWidgets('call to bloc when click on FAB', (tester) async {
      when(() => blocCat.state).thenReturn(
        const RandomCatState(status: RandomCatStatus.success),
      );
      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          BlocProvider<RandomCatBloc>(
            lazy: false,
            create: (_) => blocCat,
            child: const MaterialApp(
              home: RandomCatLayout(),
            ),
          ),
        ),
      );
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
        const RandomCatState(status: RandomCatStatus.emptyBreeds, cat: cat),
      );
      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          BlocProvider<RandomCatBloc>(
            lazy: false,
            create: (_) => blocCat,
            child: const MaterialApp(
              home: RandomCatLayout(),
            ),
          ),
        ),
      );

      verify(() => blocCat.add(SearchRandomCat())).called(1);
    });
  });
}
