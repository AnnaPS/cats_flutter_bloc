import 'package:catsapp/ui/random_cat/random_cat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class FakeRandomCatState extends Fake implements RandomCatState {}

class FakeRandomCatEvent extends Fake implements RandomCatEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(RandomCatEvent());
    registerFallbackValue(FakeRandomCatState());
  });

  group('RandomCatPage ', () {
    testWidgets('renders RandomCatPage', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          const MaterialApp(
            home: RandomCatPage(),
          ),
        ),
      );
      expect(find.byType(RandomCatPage), findsOneWidget);
    });
  });
}
