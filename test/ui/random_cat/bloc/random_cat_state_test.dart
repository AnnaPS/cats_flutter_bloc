import 'package:catsapp/ui/random_cat/pages/bloc/random_cat_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RandomCatState', () {
    test('supports value comparison', () {
      expect(const RandomCatState(), const RandomCatState());
      expect(
        const RandomCatState().toString(),
        const RandomCatState().toString(),
      );
    });
  });

  group('RandomCatInitState', () {
    test('state is init state', () {
      expect(RandomCatInitState(), RandomCatInitState());
    });
  });

  group('RandomCatStateError', () {
    test('state is error', () {
      expect(const RandomCatStateError(message: 'error'),
          const RandomCatStateError(message: 'error'));
    });
  });
  group('RandomCatLoadState', () {
    test('state is loading', () {
      expect(RandomCatLoadState(), RandomCatLoadState());
    });
  });
}
