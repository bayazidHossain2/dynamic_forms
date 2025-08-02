class ServerException implements Exception{
  final String message;
  const ServerException({required this.message});

  @override
  String toString() {
    // TODO: implement toString
    return 'Server Exception : $message';
  }
}
class LocalException implements Exception{
  final String message;
  const LocalException({required this.message});

  @override
  String toString() {
    // TODO: implement toString
    return 'Local Exception : $message';
  }
}