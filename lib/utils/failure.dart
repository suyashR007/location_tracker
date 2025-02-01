abstract class Failure {
  const Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({this.message = 'Some unexpected server failure occured!'})
      : super([message]);
  @override
  String toString() {
    return message;
  }
}
