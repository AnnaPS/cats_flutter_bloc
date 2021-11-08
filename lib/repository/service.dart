import 'dart:convert';

import 'model/cat.dart';
import 'model/result_error.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class CatService {
  CatService({
    http.Client? httpClient,
    this.baseUrl = 'https://api.thecatapi.com/v1',
  }) : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final Client _httpClient;

  Future<Cat> search() async {
    final response = await _httpClient
        .get(Uri.parse('$baseUrl/images/search?has_breeds=true'));
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return Cat.fromJson(json.decode(response.body)[0]);
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorSearchingCat();
    }
  }
}
