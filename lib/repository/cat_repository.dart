import 'model/cat.dart';
import 'service.dart';

class CatRepository {
  const CatRepository({required this.service});
  final CatService service;

  Future<Cat> search() async => service.search();
}
