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

class MockRandomCatState extends Mock implements RandomCatState {}

class MockRandomCatEvent extends Mock implements RandomCatEvent {}

void main() {
  late CatRepository catRepository;
  setUp(() {
    catRepository = CatRepository(service: CatService());
    registerFallbackValue<RandomCatEvent>(RandomCatEvent());
    registerFallbackValue<MockRandomCatState>(MockRandomCatState());
  });

  group('RandomCatPage states ', () {
    // testWidgets('renders RandomCatLayout', (tester) async {
    //   await tester.pumpWidget(RepositoryProvider(
    //     create: (_) => catRepository,
    //     child: BlocProvider<RandomCatBloc>(
    //       create: (context) => RandomCatBloc(
    //         catRepository: context.read<CatRepository>(),
    //       ),
    //       child: MaterialApp(
    //           home: mockNetworkImagesFor(() => const RandomCatLayout())),
    //     ),
    //   ));
    //   expect(find.byType(RandomCatLayout), findsOneWidget);
    // });

    testWidgets('render RandomCatPage when state is [RandomCatStateError]',
        (tester) async {
      final blocCat = MockRandomCatBloc();
      final page = BlocProvider<RandomCatBloc>(
        lazy: false,
        create: (context) => MockRandomCatBloc(),
        child: const MaterialApp(
          home: RandomCatPage(),
        ),
      );
      when(() => blocCat.state)
          .thenReturn(const RandomCatStateError(message: 'error'));
      await tester.pumpWidget(
        BlocProvider<MockRandomCatBloc>(
          create: (context) => blocCat,
          child: page,
        ),
      );
    });
  });
}
