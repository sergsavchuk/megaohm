import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:megaohm_api/megaohm_api.dart';

class MegaohmApi {
  MegaohmApi({
    required String baseUrl,
    required String authToken,
  })  : _baseUrl = baseUrl,
        _httpClient = _MegaohmHttpClient(authToken);

  final String _baseUrl;

  final http.Client _httpClient;

  Future<TmDataset> getTmById({
    required String id,
    required DateTime startDate,
    required DateTime endDate,
    required Discrete discrete,
  }) async {
    final url = Uri.parse('$_baseUrl/tm/$id?'
        'start_date=${startDate.toIsoString()}&'
        'end_date=${endDate.toIsoString()}&'
        'discrete=${discrete.name}');
    final response = await _httpClient.get(url);

    final statusCode = StatusCode.fromCode(response.statusCode);
    switch (statusCode) {
      case StatusCode.ok:
        return TmDataset.fromJson(jsonDecode(response.body) as List<dynamic>);
      case StatusCode.badRequest:
      case StatusCode.authError:
      case StatusCode.forbidden:
      case StatusCode.notFound:
      case StatusCode.tooManyRequests:
      case StatusCode.internalServerError:
        throw MegaohmRequestException(statusCode);
    }
  }
}

class _MegaohmHttpClient extends http.BaseClient {
  _MegaohmHttpClient(this._authToken);

  final http.Client _httpClient = http.Client();

  final String _authToken;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll({'Authorization': 'Bearer $_authToken'});
    return _httpClient.send(request);
  }
}

class MegaohmRequestException implements Exception {
  MegaohmRequestException(this.statusCode);

  final StatusCode statusCode;

  @override
  String toString() {
    return 'MegaohmRequestException: $statusCode';
  }
}
