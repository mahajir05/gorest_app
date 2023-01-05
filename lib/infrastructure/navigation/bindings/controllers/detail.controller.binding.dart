import 'package:get/get.dart';

import '../../../../domain/features/user/use_cases/add_user_uc.dart';
import '../../../../domain/features/user/use_cases/delete_user_uc.dart';
import '../../../../domain/features/user/use_cases/update_user_uc.dart';
import '../../../../presentation/detail/controllers/detail.controller.dart';

class DetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddUserUc>(AddUserUc(Get.find()));
    Get.put<UpdateUserUc>(UpdateUserUc(Get.find()));
    Get.put<DeleteUserUc>(DeleteUserUc(Get.find()));
    Get.lazyPut<DetailController>(
      () => DetailController(
        addUserUc: Get.find(),
        updateUserUc: Get.find(),
        deleteUserUc: Get.find(),
      ),
    );
  }
}
