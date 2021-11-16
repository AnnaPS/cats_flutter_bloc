import 'package:catsapp/repository/cat_repository.dart';
import 'package:catsapp/repository/model/result_error.dart';
import 'package:catsapp/repository/service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockService extends Mock implements CatService {}

void main() {
  group('Cat Repository', () {
    late CatService catService;
    late CatRepository catRepository;

    setUp(() {
      catService = MockService();
      catRepository = CatRepository(service: catService);
    });

    group('constructor', () {
      test('instantiates CatRepository with a required carService', () {
        expect(catRepository, isNotNull);
      });
    });

    group(('search next cat'), () {
      test('calls search method', () async {
        try {
          await catRepository.search();
        } catch (_) {}
        verify(() => catService.search()).called(1);
      });

      test('throws Result exception when search fails', () async {
        // first create a exception mock instance
        final exception = ErrorSearchingCat();
        // when calls and api and throw an exception
        when(() => catService.search()).thenThrow(exception);
        // then expect an error result
        expect(() async => catRepository.search(), throwsA(exception));
      });
    });
  });
}
