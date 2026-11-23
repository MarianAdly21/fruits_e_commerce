class CustomException implements Exception {
  final String message;

  new({required this.message});
  @override
  String toString() {
    return message;
  }
}

class CancelledByUserException extends CustomException {
  new({required super.message});
}
