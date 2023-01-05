import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:gorest_app/infrastructure/dal/daos/user/data_sources/user_remote_data_source.dart';
import 'package:gorest_app/infrastructure/dal/daos/user/models/user_data_model.dart';
import 'package:gorest_app/infrastructure/dal/daos/user/repositories/user_repository.dart';
import 'package:gorest_app/infrastructure/dal/services/models/base_list_resp.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_test.mocks.dart';

class IUserRemoteDataSourceTest extends Mock implements IUserRemoteDataSource {}

@GenerateMocks([IUserRemoteDataSourceTest])
void main() {
  late UserRepository userRepository;
  late MockIUserRemoteDataSourceTest mockIUserRemoteDataSourceTest;

  const userDataModel = UserDataModel(
    id: 1,
    name: 'name',
    email: 'email@email.com',
    gender: 'L',
    status: 'active',
  );

  setUpAll(() {
    mockIUserRemoteDataSourceTest = MockIUserRemoteDataSourceTest();
    userRepository = UserRepository(remoteDataSource: mockIUserRemoteDataSourceTest);
  });

  group('Get Users', () {
    test('success', () async {
      when(mockIUserRemoteDataSourceTest.getUsers(page: 1, perPage: 1))
          .thenAnswer((_) async => BaseListResp<UserDataModel>(data: [userDataModel]));

      final result = await userRepository.getUsers(page: 1, perPage: 1);

      expect(result, isNotNull);
      expect(result.data, isA<List<UserDataModel>>());
      expect(result.data, isNotEmpty);
      expect(result.data.length, 1);
    });

    test('failed or empty', () async {
      when(mockIUserRemoteDataSourceTest.getUsers(page: 1, perPage: 1))
          .thenAnswer((_) async => BaseListResp<UserDataModel>(data: []));

      final result = await userRepository.getUsers(page: 1, perPage: 1);

      expect(result, isNotNull);
      expect(result.data, isA<List<UserDataModel>>());
      expect(result.data, isEmpty);
    });
  });

  group('Get User Detail', () {
    test('success', () async {
      when(mockIUserRemoteDataSourceTest.getUserDetail(1)).thenAnswer((_) async => userDataModel);

      final result = await userRepository.getUserDetail(1);

      expect(result, isNotNull);
      expect(result, isA<UserDataModel>());
      expect(result?.id, 1);
      expect(result?.name, 'name');
      expect(result?.email, 'email@email.com');
      expect(result?.gender, 'L');
      expect(result?.status, 'active');
    });

    test('failed', () async {
      when(mockIUserRemoteDataSourceTest.getUserDetail(1)).thenAnswer((_) async => null);

      final result = await userRepository.getUserDetail(1);

      expect(result, isNull);
    });
  });

  group('Add User', () {
    test('success', () async {
      when(mockIUserRemoteDataSourceTest.addUser(userDataModel)).thenAnswer((_) async => userDataModel);

      final result = await userRepository.addUser(userDataModel);

      expect(result, isNotNull);
      expect(result, isA<UserDataModel>());
      expect(result?.id, 1);
      expect(result?.name, 'name');
      expect(result?.email, 'email@email.com');
      expect(result?.gender, 'L');
      expect(result?.status, 'active');
    });

    test('failed', () async {
      when(mockIUserRemoteDataSourceTest.addUser(userDataModel)).thenAnswer((_) async => null);

      final result = await userRepository.addUser(userDataModel);

      expect(result, isNull);
    });
  });

  group('update User', () {
    test('success', () async {
      when(mockIUserRemoteDataSourceTest.updateUser(userDataModel.id, userDataModel))
          .thenAnswer((_) async => userDataModel);

      final result = await userRepository.updateUser(userDataModel.id!, userDataModel);

      expect(result, isNotNull);
      expect(result, isA<UserDataModel>());
      expect(result?.id, 1);
      expect(result?.name, 'name');
      expect(result?.email, 'email@email.com');
      expect(result?.gender, 'L');
      expect(result?.status, 'active');
    });

    test('failed', () async {
      when(mockIUserRemoteDataSourceTest.updateUser(userDataModel.id, userDataModel)).thenAnswer((_) async => null);

      final result = await userRepository.updateUser(userDataModel.id!, userDataModel);

      expect(result, isNull);
    });
  });

  group('delete User', () {
    test('success', () async {
      when(mockIUserRemoteDataSourceTest.deleteUser(userDataModel.id)).thenAnswer((_) async => true);

      final result = await userRepository.deleteUser(userDataModel.id!);

      expect(result, isNotNull);
      expect(result, true);
    });

    test('failed', () async {
      when(mockIUserRemoteDataSourceTest.deleteUser(userDataModel.id)).thenAnswer((_) async => false);

      final result = await userRepository.deleteUser(userDataModel.id!);

      expect(result, false);
    });
  });
}
