import '../entities/user_data_entity.dart';
import '../repositories/i_user_repository.dart';

class AddUserUc {
  final IUserRepository userRepository;

  AddUserUc(this.userRepository);

  Future<UserDataEntity?> call(UserDataEntity userData) {
    return userRepository.addUser(userData);
  }
}
