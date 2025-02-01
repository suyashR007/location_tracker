abstract class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}

class ServerException extends ApiException {
  final int? code;

  ServerException({
    required String message,
    this.code,
  }) : super(message);
}

class NetworkException extends ApiException {
  NetworkException(super.message);
}

class NoInternetConnection extends ApiException {
  NoInternetConnection(super.message);
}

class UnknownException extends ApiException {
  UnknownException(super.message);
}
