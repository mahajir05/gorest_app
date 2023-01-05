import '../entities/user_data_entity.dart';
import '../repositories/i_user_repository.dart';

class GetUserDetailUc {
  final IUserRepository userRepository;

  GetUserDetailUc(this.userRepository);

  Future<UserDataEntity?> call(int id) {
    return userRepository.getUserDetail(1);
  }
}
