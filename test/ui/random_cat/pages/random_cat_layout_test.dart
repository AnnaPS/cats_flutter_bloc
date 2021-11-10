import 'package:bloc_test/bloc_test.dart';
import 'package:catsapp/ui/random_cat/random_cat.dart';
import 'package:catsapp/utils/const_keys_app.dart';
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
        'render FailureRandomCatView when state is [RandomCatStatus.failure]',
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
      expect(find.byKey(const Key(ConstWidgetKeysApp.RandomCatFailure)),
          findsOneWidget);
    });

    testWidgets('render LoadingView when state is [RandomCatStatus.loading]',
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
      expect(
          find.byKey(const Key(ConstWidgetKeysApp.CatLoading)), findsOneWidget);
    });

    testWidgets(
        'render SuccessRandomCatView when state is [RandomCatStatus.success]',
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
      expect(find.byKey(const Key(ConstWidgetKeysApp.RandomCatSuccess)),
          findsOneWidget);
    });

    testWidgets(
        'render InitialRandomCatView when state is [RandomCatStatus.initial]',
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
      expect(find.byKey(const Key(ConstWidgetKeysApp.RandomCatInitial)),
          findsOneWidget);
    });
  });

  group('Click on FAB ', () {
    testWidgets('call to bloc to get next cat', (tester) async {
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

  group('Call to SearchRandomCat on BlocListener ', () {
    const cat = Cat(id: '1', breeds: [], width: 1, height: 1, url: 'www');
    testWidgets('Call to event when breeds is empty', (tester) async {
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
