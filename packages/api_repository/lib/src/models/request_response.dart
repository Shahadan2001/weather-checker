class RequestStatus<T> {
  final String? message;
  final T? body;
  final int? status;
  const RequestStatus(this.status, this.message, this.body);

  static const SUCCESS = 1;
  static const FAILURE = 0;
}
