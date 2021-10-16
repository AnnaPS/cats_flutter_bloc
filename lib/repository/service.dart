import 'dart:convert';

import 'package:catsapp/repository/model/cat.dart';
import 'package:catsapp/repository/model/result_error.dart';
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
    final result = json.decode(response.body);

    if (response.statusCode == 200) {
      return Cat.fromJson(result[0]);
    } else {
      throw ResultError(message: result);
    }
  }
}
