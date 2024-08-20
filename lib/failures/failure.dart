abstract class Failure {
  abstract String message;
}

class ServerFailure extends Failure {
  ServerFailure({required this.message});

  @override
  String message;
}

class DatabaseFailure extends Failure {
  DatabaseFailure({required this.message});

  @override
  String message;
}

class PermissionFailure extends Failure {
  PermissionFailure({required this.message});

  @override
  String message;
}

class UnknownFailure extends Failure {
  UnknownFailure({required this.message});

  @override
  String message;
}