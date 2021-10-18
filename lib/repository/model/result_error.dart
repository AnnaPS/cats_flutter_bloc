class ResultError implements Exception {
  const ResultError({required this.message});

  final String message;

  static ResultError fromJson(Map<Object, String> json) {
    return ResultError(
      message: json['message'] as String,
    );
  }
}
