import 'package:bloc_test/bloc_test.dart';
import 'package:catsapp/repository/cat_repository.dart';
import 'package:catsapp/repository/service.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_bloc.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_event.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_state.dart';
import 'package:catsapp/ui/random_cat/pages/random_cat_layout.dart';
import 'package:catsapp/ui/random_cat/pages/random_cat_page.dart';
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
  late Widget page;

  setUp(() {
    catRepository = CatRepository(service: CatService());
    registerFallbackValue<RandomCatEvent>(RandomCatEvent());
    registerFallbackValue<MockRandomCatState>(MockRandomCatState());
    page = BlocProvider<RandomCatBloc>(
      lazy: false,
      create: (context) => MockRandomCatBloc(),
      child: const MaterialApp(
        home: RandomCatPage(),
      ),
    );
  });

  group('RandomCatPage states ', () {
    testWidgets('renders RandomCatLayout', (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(page));
      expect(find.byType(RandomCatLayout), findsOneWidget);
    });

    testWidgets('render RandomCatLayout when state is [RandomCatStateError]',
        (tester) async {
      final blocCat = MockRandomCatBloc();
      when(() => blocCat.state)
          .thenReturn(const RandomCatStateError(message: 'error'));
      await mockNetworkImagesFor(() => tester.pumpWidget(page));
    });

    testWidgets('render RandomCatLayout when state is [RandomCatLoadState]',
        (tester) async {
      final blocCat = MockRandomCatBloc();
      when(() => blocCat.state).thenReturn(RandomCatLoadState());
      await mockNetworkImagesFor(() => tester.pumpWidget(page));
    });
  });
}
