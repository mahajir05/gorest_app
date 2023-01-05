import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gorest_app/infrastructure/dal/daos/user/data_sources/user_remote_data_source.dart';
import 'package:gorest_app/infrastructure/dal/daos/user/models/user_data_model.dart';
import 'package:gorest_app/infrastructure/dal/services/api_service.dart';
import 'package:gorest_app/infrastructure/dal/services/models/base_list_resp.dart';

void main() {
  group('[online]', () {
    late ApiService apiService;
    late UserRemoteDataSource remoteDataSource;

    setUpAll(() {
      apiService = ApiService(dio: Dio());
      remoteDataSource = UserRemoteDataSource(apiService: apiService);
    });

    test('get users', () async {
      final result = await remoteDataSource.getUsers(page: 1, perPage: 5);

      expect(result, isA<BaseListResp>());
      expect(result.data, isA<List<UserDataModel>>());
      expect(result.data.length, 5);
      expect(result.page, 1);
      expect(result.totalDataOnApi, isA<int>());
      // expect(result.totalDataOnApi, 4225);
    });

    // group('Get User Detail', () {
    //   test('success', () async {
    //     const int userId = 4728;
    //     final result = await remoteDataSource.getUserDetail(userId);

    //     expect(result, isA<UserDataModel>());
    //     expect(result?.id, userId);
    //   });

    //   test('failed user not found', () async {
    //     const int userId = 4767;
    //     final result = await remoteDataSource.getUserDetail(userId);

    //     expect(result, isNull);
    //   });
    // });
  });
}
