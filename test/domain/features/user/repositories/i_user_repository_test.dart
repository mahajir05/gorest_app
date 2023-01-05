import 'package:flutter_test/flutter_test.dart';
import 'package:gorest_app/domain/features/user/entities/pagination_entity.dart';
import 'package:gorest_app/domain/features/user/entities/user_data_entity.dart';
import 'package:gorest_app/domain/features/user/repositories/i_user_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'i_user_repository_test.mocks.dart';

class IUserRepositoryTest extends Mock implements IUserRepository {}

@GenerateMocks([IUserRepositoryTest])
void main() {
  late IUserRepository iUserRepository;

  setUpAll(() {
    iUserRepository = MockIUserRepositoryTest();
  });

  test('IUserRepository Test get users', () async {
    when(iUserRepository.getUsers(page: 1, perPage: 5))
        .thenAnswer((_) async => PaginationEntity<UserDataEntity>(data: [const UserDataEntity()]));

    final result = await iUserRepository.getUsers(page: 1, perPage: 5);

    expect(result, isNotNull);
    expect(result.data, isList);
    expect(result.data, isA<List<UserDataEntity>>());
  });

  test('IUserRepository Test get user detail', () async {
    when(iUserRepository.getUserDetail(1)).thenAnswer((_) async => const UserDataEntity(id: 1));

    final result = await iUserRepository.getUserDetail(1);

    expect(result, isNotNull);
    expect(result, isA<UserDataEntity>());
    expect(result?.id, 1);
  });

  test('IUserRepository Test add user', () async {
    const user = UserDataEntity(id: 1);
    when(iUserRepository.addUser(user)).thenAnswer((_) async => user);

    final result = await iUserRepository.addUser(user);

    expect(result, isNotNull);
    expect(result, isA<UserDataEntity>());
    expect(result?.id, 1);
  });

  test('IUserRepository Test update user', () async {
    const user = UserDataEntity(id: 1, name: 'name');
    when(iUserRepository.updateUser(1, user)).thenAnswer((_) async => user);

    final result = await iUserRepository.updateUser(1, user);

    expect(result, isNotNull);
    expect(result, isA<UserDataEntity>());
    expect(result?.id, 1);
    expect(result?.name, 'name');
  });

  test('IUserRepository Test delete user', () async {
    when(iUserRepository.deleteUser(1)).thenAnswer((_) async => true);

    final result = await iUserRepository.deleteUser(1);

    expect(result, isNotNull);
    expect(result, true);
  });
}
