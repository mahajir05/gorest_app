import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../domain/features/user/repositories/i_user_repository.dart';
import '../../../../domain/features/user/use_cases/get_users_uc.dart';
import '../../../../presentation/home/controllers/home.controller.dart';
import '../../../dal/daos/user/data_sources/user_remote_data_source.dart';
import '../../../dal/daos/user/repositories/user_repository.dart';
import '../../../dal/services/api_service.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Dio>(Dio());
    Get.put<ApiService>(ApiService(dio: Get.find()));
    Get.put<IUserRemoteDataSource>(UserRemoteDataSource(apiService: Get.find()));
    Get.put<IUserRepository>(UserRepository(remoteDataSource: Get.find()));
    Get.put<GetUsersUc>(GetUsersUc(userRepository: Get.find()));
    Get.lazyPut<HomeController>(
      () => HomeController(getUsersUc: Get.find()),
    );
  }
}
