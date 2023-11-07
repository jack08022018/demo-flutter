class CommonError implements Exception {
  final String message;

  const CommonError({
    required this.message
  });
}