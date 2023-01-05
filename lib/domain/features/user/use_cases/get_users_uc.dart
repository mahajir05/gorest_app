import '../entities/pagination_entity.dart';
import '../entities/user_data_entity.dart';
import '../repositories/i_user_repository.dart';

class GetUsersUc {
  final IUserRepository userRepository;

  GetUsersUc({required this.userRepository});

  Future<PaginationEntity<UserDataEntity>> call(int page, int perPage) {
    return userRepository.getUsers(page: page, perPage: perPage);
  }
}
