import 'package:flutter_test/flutter_test.dart';
import 'package:gorest_app/domain/features/user/entities/pagination_entity.dart';
import 'package:gorest_app/domain/features/user/entities/user_data_entity.dart';
import 'package:gorest_app/domain/features/user/repositories/i_user_repository.dart';
import 'package:gorest_app/domain/features/user/use_cases/add_user_uc.dart';
import 'package:gorest_app/domain/features/user/use_cases/delete_user_uc.dart';
import 'package:gorest_app/domain/features/user/use_cases/get_user_detail_uc.dart';
import 'package:gorest_app/domain/features/user/use_cases/get_users_uc.dart';
import 'package:gorest_app/domain/features/user/use_cases/update_user_uc.dart';
import 'package:mockito/mockito.dart';

import '../repositories/i_user_repository_test.mocks.dart';

void main() {
  late IUserRepository userRepository;

  setUpAll(() {
    userRepository = MockIUserRepositoryTest();
  });

  group('get users usecase', () {
    late GetUsersUc getUsersUc;
    setUp(() {
      getUsersUc = GetUsersUc(userRepository: userRepository);
    });

    test('success', () async {
      when(userRepository.getUsers(page: 1, perPage: 5))
          .thenAnswer((_) async => PaginationEntity<UserDataEntity>(data: [const UserDataEntity()]));

      final result = await getUsersUc(1, 5);

      expect(result, isNotNull);
      expect(result, isA<PaginationEntity<UserDataEntity>>());
      expect(result.data, isList);
      expect(result.data, isA<List<UserDataEntity>>());
    });

    test('failed or empty', () async {
      when(userRepository.getUsers(page: 1, perPage: 5))
          .thenAnswer((_) async => PaginationEntity<UserDataEntity>(data: []));

      final result = await getUsersUc(1, 5);

      expect(result, isNotNull);
      expect(result.data, isList);
      expect(result.data, isEmpty);
    });
  });

  group('get user detail usecase', () {
    late GetUserDetailUc usecase;
    setUp(() {
      usecase = GetUserDetailUc(userRepository);
    });

    test('success', () async {
      when(userRepository.getUserDetail(1)).thenAnswer((_) async => const UserDataEntity(id: 1));

      final result = await usecase(1);

      expect(result, isNotNull);
      expect(result, isA<UserDataEntity>());
    });

    test('failed or empty', () async {
      when(userRepository.getUserDetail(1)).thenAnswer((_) async => null);

      final result = await usecase(1);

      expect(result, isNull);
    });
  });

  group('add user usecase', () {
    late AddUserUc usecase;
    const user = UserDataEntity(id: 1);
    setUp(() {
      usecase = AddUserUc(userRepository);
    });

    test('success', () async {
      when(userRepository.addUser(user)).thenAnswer((_) async => user);

      final result = await usecase(user);

      expect(result, isNotNull);
      expect(result, isA<UserDataEntity>());
    });

    test('failed', () async {
      when(userRepository.addUser(user)).thenAnswer((_) async => null);

      final result = await usecase(user);

      expect(result, isNull);
    });
  });

  group('update user usecase', () {
    late UpdateUserUc usecase;
    const user = UserDataEntity(id: 1, name: 'name');
    setUp(() {
      usecase = UpdateUserUc(userRepository);
    });

    test('success', () async {
      when(userRepository.updateUser(1, user)).thenAnswer((_) async => user);

      final result = await usecase(1, user);

      expect(result, isNotNull);
      expect(result, isA<UserDataEntity>());
    });

    test('failed', () async {
      when(userRepository.updateUser(1, user)).thenAnswer((_) async => null);

      final result = await usecase(1, user);

      expect(result, isNull);
    });
  });

  group('delete user usecase', () {
    late DeleteUserUc usecase;
    setUp(() {
      usecase = DeleteUserUc(userRepository);
    });

    test('success', () async {
      when(userRepository.deleteUser(1)).thenAnswer((_) async => true);

      final result = await usecase(1);

      expect(result, isNotNull);
      expect(result, isA<bool>());
      expect(result, true);
    });

    test('failed', () async {
      when(userRepository.deleteUser(1)).thenAnswer((_) async => false);

      final result = await usecase(1);

      expect(result, isNotNull);
      expect(result, isA<bool>());
      expect(result, false);
    });
  });
}
