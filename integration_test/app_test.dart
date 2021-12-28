import 'package:catsapp/main.dart' as app;
import 'package:catsapp/utils/const_keys_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Cats App', (tester) async {
    // load the app
    await tester.pumpApp();
    // check appbar title
    expect(find.text('Cats App'), findsOneWidget);
    // check random cats
    await tester.randomCats();
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

  Future<void> randomCats() async {
    // wait 4 seconds for success view
    await pumpAndSettle(const Duration(seconds: 4));
    // view is success
    expect(
      find.byKey(const Key(ConstWidgetKeysApp.RandomCatSuccess)),
      findsOneWidget,
    );
    // loop for do tap on the button 3 times
    for (var i = 0; i < 3; i++) {
      // tap
      await getNextCat();
      // wait
      await pumpAndSettle(const Duration(seconds: 2));
      // success
      expect(
        find.byKey(const Key(ConstWidgetKeysApp.RandomCatSuccess)),
        findsOneWidget,
      );
      // wait 3 seconds for load the network image
      await pumpAndSettle(const Duration(seconds: 3));
    }
  }
}
