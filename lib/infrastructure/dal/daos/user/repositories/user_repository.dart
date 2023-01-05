import 'package:gorest_app/domain/features/user/entities/user_data_entity.dart';

import '../../../../../domain/features/user/entities/pagination_entity.dart';
import '../../../../../domain/features/user/repositories/i_user_repository.dart';
import '../data_sources/user_remote_data_source.dart';
import '../models/user_data_model.dart';

class UserRepository implements IUserRepository {
  final IUserRemoteDataSource remoteDataSource;

  UserRepository({required this.remoteDataSource});

  @override
  Future<PaginationEntity<UserDataEntity>> getUsers({int? page, int? perPage}) {
    return remoteDataSource.getUsers(page: page, perPage: perPage);
  }

  @override
  Future<UserDataEntity?> getUserDetail(int id) {
    return remoteDataSource.getUserDetail(id);
  }

  @override
  Future<UserDataEntity?> addUser(UserDataEntity userData) {
    final userDataMdl = UserDataModel(
      id: userData.id,
      name: userData.name,
      email: userData.email,
      gender: userData.gender,
      status: userData.status,
    );
    return remoteDataSource.addUser(userDataMdl);
  }

  @override
  Future<UserDataEntity?> updateUser(int id, UserDataEntity userData) {
    final userDataMdl = UserDataModel(
      id: userData.id,
      name: userData.name,
      email: userData.email,
      gender: userData.gender,
      status: userData.status,
    );
    return remoteDataSource.updateUser(id, userDataMdl);
  }

  @override
  Future<bool> deleteUser(int id) {
    return remoteDataSource.deleteUser(id);
  }
}
