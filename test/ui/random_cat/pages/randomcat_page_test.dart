import 'package:bloc_test/bloc_test.dart';
import 'package:catsapp/repository/cat_repository.dart';
import 'package:catsapp/repository/service.dart';
import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_bloc.dart';
import 'package:catsapp/ui/random_cat/pages/random_cat_page.dart';
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

    randomCatView = RepositoryProvider(
      create: (_) => catRepository,
      child: BlocProvider<RandomCatBloc>(
        lazy: false,
        create: (_) => blocCat,
        child: const MaterialApp(
          home: RandomCatPage(),
        ),
      ),
    );
  });

  group('RandomCatPage ', () {
    testWidgets('renders RandomCatPage', (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(randomCatView));
      expect(find.byType(RandomCatPage), findsOneWidget);
    });
  });
}
