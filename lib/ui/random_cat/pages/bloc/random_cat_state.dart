part of 'random_cat_bloc.dart';

enum RandomCatStatus { initial, loading, success, failure, emptyBreeds }

extension RandomCatStatusX on RandomCatStatus {
  bool get isInitial => this == RandomCatStatus.initial;
  bool get isLoading => this == RandomCatStatus.loading;
  bool get isSuccess => this == RandomCatStatus.success;
  bool get isFailure => this == RandomCatStatus.failure;
  bool get isEmptyBreeds => this == RandomCatStatus.emptyBreeds;
}

class RandomCatState extends Equatable {
  const RandomCatState({
    this.status = RandomCatStatus.initial,
    Cat? cat,
  }) : cat = cat ?? Cat.empty;

  final Cat cat;
  final RandomCatStatus status;

  @override
  List<Object?> get props => [cat, status];

  RandomCatState copyWith({
    Cat? cat,
    RandomCatStatus? status,
  }) {
    return RandomCatState(
      cat: cat ?? this.cat,
      status: status ?? this.status,
    );
  }
}
