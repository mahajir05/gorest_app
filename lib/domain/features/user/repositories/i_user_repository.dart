import '../entities/pagination_entity.dart';
import '../entities/user_data_entity.dart';

abstract class IUserRepository {
  Future<PaginationEntity<UserDataEntity>> getUsers({int? page, int? perPage});
  Future<UserDataEntity?> getUserDetail(int id);
  Future<UserDataEntity?> addUser(UserDataEntity userData);
  Future<UserDataEntity?> updateUser(int id, UserDataEntity userData);
  Future<bool> deleteUser(int id);
}
