abstract class Failure {
  final String message;


  const new({required this.message});
}

class ServerFailure extends Failure {
  const new({required super.message});
}