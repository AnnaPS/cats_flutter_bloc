import 'package:bloc_test/bloc_test.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_bloc.dart';
import 'package:catsapp/ui/random_cat/random_cat.dart';
import 'package:catsapp/utils/const_keys_app.dart';
import 'package:flutter/material.dart';
import 'package:catsapp/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRandomCatBloc extends MockBloc<RandomCatEvent, RandomCatState>
    implements RandomCatBloc {}

class FakeRandomCatState extends Fake implements RandomCatState {}

class FakeRandomCatEvent extends Fake implements RandomCatEvent {}

void main() {
  late MockRandomCatBloc blocCat;

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    // Register the event and the state
    registerFallbackValue(FakeRandomCatEvent());
    registerFallbackValue(FakeRandomCatState());
  });
  setUp(() {
    blocCat = MockRandomCatBloc();
  });

  group('CatsApp', () {
    testWidgets('renders correct AppBar text', (tester) async {
      await tester.pumpApp();

      expect(find.text('Cats App'), findsOneWidget);
    });

    testWidgets('loading', (tester) async {
      await tester.pumpApp();
      await tester.getNextCat();
      expect(find.byType(LoadingView), findsOneWidget);
    });
    testWidgets('get next cat', (tester) async {
      when(() => blocCat.state).thenReturn(
        const RandomCatState(status: RandomCatStatus.success),
      );
      await tester.pumpApp();
      expect(find.byKey(const Key(ConstWidgetKeysApp.RandomCatSuccess)),
          findsOneWidget);
      await tester.getNextCat();
      verify(() => blocCat.add(SearchRandomCat())).called(1);
    });
  });
}

extension on WidgetTester {
  Future<void> pumpApp() async {
    app.main();
    await pump();
  }

  Future<void> getNextCat() async {
    await tap(
      find.byKey(const Key(ConstWidgetKeysApp.RandomCatFabButtonKey)),
    );
    await pump();
  }
}
