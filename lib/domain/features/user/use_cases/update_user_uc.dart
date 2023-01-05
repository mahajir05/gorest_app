import '../entities/user_data_entity.dart';
import '../repositories/i_user_repository.dart';

class UpdateUserUc {
  final IUserRepository userRepository;

  UpdateUserUc(this.userRepository);

  Future<UserDataEntity?> call(int id, UserDataEntity userData) {
    return userRepository.updateUser(id, userData);
  }
}
