import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gorest_app/infrastructure/dal/services/api_service.dart';

void main() {
  late Dio dio;
  late ApiService apiService;

  const String baseUrl = 'https://gorest.co.in';
  const String token = 'a1c2e1ca83408f458729a6fede314a58a83ff5e74c3a2e0e605c8a03f85ab0f5';

  setUpAll(() {
    dio = Dio();
    apiService = ApiService(dio: dio);
  });

  group('ApiService [GET]', () {
    test('get users', () async {
      const String apiPath = '/public/v2/users';
      const Map<String, dynamic> request = {};

      final result = await apiService.baseUrl(baseUrl).tokenBearer(token).get(
            apiPath: apiPath,
            request: request,
          );

      expect(result.statusCode, 200);
      expect(result.data, isNotNull);
    });

    test('get users with paging', () async {
      const String apiPath = '/public/v2/users?page=1&per_page=5';
      const Map<String, dynamic> request = {};

      final result = await apiService.baseUrl(baseUrl).tokenBearer(token).get(
            apiPath: apiPath,
            request: request,
          );

      expect(result.statusCode, 200);
      expect(result.data, isNotNull);
    });
  });
}
