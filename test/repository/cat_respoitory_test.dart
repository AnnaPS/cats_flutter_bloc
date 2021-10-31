import 'package:catsapp/repository/cat_repository.dart';
import 'package:catsapp/repository/model/breed.dart';
import 'package:catsapp/repository/model/cat.dart';
import 'package:catsapp/repository/model/result_error.dart';
import 'package:catsapp/repository/model/weight.dart';
import 'package:catsapp/repository/service.dart' as cat_service;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockService extends Mock implements cat_service.CatService {}

class MockErrorSearchingCat extends Mock implements ErrorSearchingCat {}

class MockErrorEmptyResponse extends Mock implements ErrorEmptyResponse {}

void main() {
  group('Cat Repository', () {
    late cat_service.CatService catService;
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

    group('equatable object', () {
      test('cat equatable, two different cats', () {
        const cat =
            Cat(breeds: <Breed>[], id: '1', url: 'www', width: 1, height: 1);
        const cat2 =
            Cat(breeds: <Breed>[], id: '2', url: 'www', width: 2, height: 2);
        expect(cat == cat2, false);
        expect(cat.hashCode == cat2.hashCode, false);
      });

      test('breed equatable, two equals breeds ', () {
        const breed = Breed(
            weight: Weight(),
            id: '1',
            name: 'breed',
            cfaUrl: '',
            vetstreetUrl: 'www',
            vcahospitalsUrl: 'www',
            temperament: '',
            origin: '',
            countryCodes: '',
            countryCode: '',
            description: '',
            lifeSpan: '',
            indoor: 1,
            lap: 1,
            altNames: '',
            adaptability: 1,
            affectionLevel: 1,
            childFriendly: 1,
            dogFriendly: 1,
            energyLevel: 1,
            grooming: 1,
            healthIssues: 1,
            intelligence: 1,
            sheddingLevel: 1,
            socialNeeds: 1,
            strangerFriendly: 1,
            vocalisation: 1,
            experimental: 1,
            hairless: 1,
            natural: 1,
            rare: 1,
            rex: 1,
            suppressedTail: 1,
            shortLegs: 1,
            wikipediaUrl: 'www',
            hypoallergenic: 1,
            referenceImageId: '1');
        const breed2 = Breed(
            weight: Weight(),
            id: '1',
            name: 'breed',
            cfaUrl: '',
            vetstreetUrl: 'www',
            vcahospitalsUrl: 'www',
            temperament: '',
            origin: '',
            countryCodes: '',
            countryCode: '',
            description: '',
            lifeSpan: '',
            indoor: 1,
            lap: 1,
            altNames: '',
            adaptability: 1,
            affectionLevel: 1,
            childFriendly: 1,
            dogFriendly: 1,
            energyLevel: 1,
            grooming: 1,
            healthIssues: 1,
            intelligence: 1,
            sheddingLevel: 1,
            socialNeeds: 1,
            strangerFriendly: 1,
            vocalisation: 1,
            experimental: 1,
            hairless: 1,
            natural: 1,
            rare: 1,
            rex: 1,
            suppressedTail: 1,
            shortLegs: 1,
            wikipediaUrl: 'www',
            hypoallergenic: 1,
            referenceImageId: '1');
        expect(breed == breed2, true);
        expect(breed.hashCode == breed2.hashCode, true);
      });

      test('weight equatable, two different weight', () {
        const weight = Weight(imperial: 'imperial', metric: 'metric');
        const weight2 = Weight(imperial: 'imperial', metric: 'metric');
        expect(weight == weight2, true);
        expect(weight.hashCode == weight2.hashCode, true);
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
        final exception = MockErrorSearchingCat();
        // when calls and api and throw an exception
        when(() => catService.search()).thenThrow(exception);
        // then expect an error result
        expect(() async => catRepository.search(), throwsA(exception));
      });
    });
  });
}
