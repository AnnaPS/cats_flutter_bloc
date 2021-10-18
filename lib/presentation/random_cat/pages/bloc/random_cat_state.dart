import '../../../../repository/model/cat.dart';
import 'package:equatable/equatable.dart';

class RandomCatState extends Equatable {
  const RandomCatState({this.cat});
  final Cat? cat;

  @override
  List<Object?> get props => [cat];

  RandomCatState copyWith({
    Cat? cat,
  }) {
    return RandomCatState(
      cat: cat ?? this.cat,
    );
  }
}

class RandomCatEmptyBreedsState extends RandomCatState {
  const RandomCatEmptyBreedsState({required this.urlPhoto});
  final String urlPhoto;
}

class RandomCatEmptyBreedsState extends RandomCatState {
  const RandomCatEmptyBreedsState({required this.urlPhoto});
  final String urlPhoto;
}

class RandomCatInitState extends RandomCatState {}

class RandomCatLoadState extends RandomCatState {}
