enum StatusCode {
  ok(200, 'OK'),
  badRequest(400, 'Bad Request'),
  authError(401, 'Authentication Error'),
  forbidden(403, 'Forbidden'),
  notFound(404, 'Not Found'),
  tooManyRequests(429, 'Too Many Requests'),
  internalServerError(500, 'Internal Server Error');

  const StatusCode(this.code, this.description);

  final int code;
  final String description;

  static StatusCode fromCode(int code) {
    return StatusCode.values.firstWhere((element) => element.code == code);
  }

  @override
  String toString() => '$code: $description';
}
