import 'package:flutter_test/flutter_test.dart';
import 'package:catsapp/ui/random_cat/random_cat.dart';

void main() {
  group('RandomCatStatusX ', () {
    test('returns correct values for RandomCatStatus.initial', () {
      const status = RandomCatStatus.initial;
      expect(status.isInitial, isTrue);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
      expect(status.isEmptyBreeds, isFalse);
    });

    test('returns correct values for RandomCatStatus.loading', () {
      const status = RandomCatStatus.loading;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
      expect(status.isEmptyBreeds, isFalse);
    });

    test('returns correct values for RandomCatStatus.isSuccess', () {
      const status = RandomCatStatus.success;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isFailure, isFalse);
      expect(status.isEmptyBreeds, isFalse);
    });

    test('returns correct values for RandomCatStatus.isFailure', () {
      const status = RandomCatStatus.failure;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isTrue);
      expect(status.isEmptyBreeds, isFalse);
    });

    test('returns correct values for RandomCatStatus.isEmptyBreeds', () {
      const status = RandomCatStatus.emptyBreeds;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
      expect(status.isEmptyBreeds, isTrue);
    });
  });
}
