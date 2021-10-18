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

class RandomCatStateError extends RandomCatState {
  const RandomCatStateError({required this.message});
  final String message;
}

class RandomCatInitState extends RandomCatState {}

class RandomCatLoadState extends RandomCatState {}
