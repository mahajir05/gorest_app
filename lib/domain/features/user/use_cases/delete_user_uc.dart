import '../repositories/i_user_repository.dart';

class DeleteUserUc {
  final IUserRepository userRepository;

  DeleteUserUc(this.userRepository);

  Future<bool> call(int id) {
    return userRepository.deleteUser(id);
  }
}
