import 'package:catsapp/ui/random_cat/random_cat.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RandomCatEvent', () {
    test('supports comparisons', () {
      expect(RandomCatEvent(), RandomCatEvent());
    });

    group('SearchRandomCat', () {
      test('supports comparisons', () {
        expect(SearchRandomCat(), SearchRandomCat());
      });
    });
  });
}
