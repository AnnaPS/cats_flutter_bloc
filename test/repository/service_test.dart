import 'package:catsapp/repository/model/breed.dart';
import 'package:catsapp/repository/model/cat.dart';
import 'package:catsapp/repository/model/result_error.dart';
import 'package:catsapp/repository/model/weight.dart';
import 'package:catsapp/repository/service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttp extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

class MockErrorSearchingCat extends Mock implements ErrorSearchingCat {}

class MockErrorEmptyResponse extends Mock implements ErrorEmptyResponse {}

void main() {
  group('Service', () {
    late CatService catService;
    late MockHttp httpClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });
    setUp(() {
      httpClient = MockHttp();
      catService = CatService(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not required an httpClient', () {
        expect(CatService(), isNotNull);
      });
    });

    group(('catSearch'), () {
      test('make correct http request', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('[]');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await catService.search();
        } catch (_) {}
        verify(() => httpClient.get(Uri.parse(
                'https://api.thecatapi.com/v1/images/search?has_breeds=true')))
            .called(1);
      });

      test('throws ResultError on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(catService.search(), throwsA(isA<ErrorSearchingCat>()));
      });

      test('throws ResultError on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(catService.search(), throwsA(isA<ErrorEmptyResponse>()));
      });

      test('return a correct Cat on a valid response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '[{'
          '"breeds":[{"weight":{"imperial":"8 - 15","metric":"4 - 7"},'
          '"id":"asho","name":"American Shorthair",'
          '"cfa_url":"http://cfa.org/Breeds/BreedsAB/AmericanShorthair.aspx",'
          '"vetstreet_url":"http://www.vetstreet.com/cats/american-shorthair",'
          '"vcahospitals_url":"https://vcahospitals.com/know-your-pet/cat-breeds/american-shorthair",'
          '"temperament":"Active, Curious, Easy Going, Playful, Calm",'
          '"origin":"United States",'
          '"country_codes":"US",'
          '"country_code":"US",'
          '"description":"The American Shorthair'
          ' is known for its longevity,'
          'robust health, good looks, sweet personality, '
          'and amiability with children, dogs, and other pets",'
          '"life_span":"15 - 17",'
          '"indoor":0,'
          '"lap":1,'
          '"alt_names":"Domestic Shorthair",'
          '"adaptability":5,'
          '"affection_level":5,'
          '"child_friendly":4,'
          '"dog_friendly":5,'
          '"energy_level":3,'
          '"grooming":1,'
          '"health_issues":3,'
          '"intelligence":3,'
          '"shedding_level":3,'
          '"social_needs":4,"stranger_friendly":3,'
          '"vocalisation":3,'
          '"experimental":0,'
          '"hairless":0,'
          '"natural":1,'
          '"rare":0,'
          '"rex":0,'
          '"suppressed_tail":0,'
          '"short_legs":0,'
          '"wikipedia_url":"https://en.wikipedia.org/wiki/American_Shorthair",'
          '"hypoallergenic":0,'
          '"reference_image_id":"JFPROfGtQ"}],'
          '"id":"MuEGe1-Sz",'
          '"url":"https://cdn2.thecatapi.com/images/MuEGe1-Sz.jpg",'
          '"width":3000,'
          '"height":2002}]',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final result = await catService.search();
        expect(
          result,
          isA<Cat>()
              .having((cat) => cat.url, 'url',
                  'https://cdn2.thecatapi.com/images/MuEGe1-Sz.jpg')
              .having((cat) => cat.width, 'width', 3000)
              .having((cat) => cat.height, 'height', 2002)
              .having((cat) => cat.id, 'id', 'MuEGe1-Sz')
              .having(
            (cat) => cat.breeds,
            'breeds',
            [
              isA<Breed>()
                  .having((breed) => breed.name, 'name', 'American Shorthair')
                  .having((breed) => breed.id, 'id', 'asho')
                  .having(
                      (breed) => breed.weight,
                      'weight',
                      isA<Weight>()
                          .having(
                              (weight) => weight.imperial, 'imperial', '8 - 15')
                          .having((weight) => weight.metric, 'metric', '4 - 7'))
            ],
          ),
        );
      });
    });
  });
}
