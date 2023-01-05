import 'package:get/get.dart';

import '../../../domain/features/user/entities/user_data_entity.dart';
import '../../../domain/features/user/use_cases/add_user_uc.dart';
import '../../../domain/features/user/use_cases/delete_user_uc.dart';
import '../../../domain/features/user/use_cases/update_user_uc.dart';

class DetailController extends GetxController {
  final AddUserUc addUserUc;
  final UpdateUserUc updateUserUc;
  final DeleteUserUc deleteUserUc;
  DetailController({required this.addUserUc, required this.updateUserUc, required this.deleteUserUc});

  RxBool isLoadingAddUser = false.obs;
  RxBool isLoadingUpdateUser = false.obs;

  Rx<UserDataEntity?> userData = Rxn<UserDataEntity>();

  Rx<String?> gender = Rxn<String>();
  Rx<String?> status = Rxn<String>();

  @override
  void onInit() {
    super.onInit();

    List args = Get.arguments as List;
    bool isGetFromApi = args[0];
    getUserData(isGetFromApi: isGetFromApi, data: args[1]);
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void getUserData({bool isGetFromApi = false, UserDataEntity? data}) {
    if (isGetFromApi) {
      return;
    }
    userData.value = data;
    gender.value = data?.gender;
    status.value = data?.status ?? 'active';
  }

  void addUser(
      {String? name,
      String? email,
      String? gender,
      String? status,
      required Function() onSuccess,
      required Function() onFailed}) async {
    isLoadingAddUser.value = true;
    UserDataEntity? result;
    if (gender != null && status != null) {
      result = await addUserUc(
        UserDataEntity(
          name: name,
          email: email,
          gender: gender,
          status: status,
        ),
      );
    }

    if (result != null) {
      onSuccess();
      isLoadingAddUser.value = false;
      return;
    }
    onFailed();
    isLoadingAddUser.value = false;
  }

  void updateUser(
      {String? name,
      String? email,
      String? gender,
      String? status,
      required Function() onSuccess,
      required Function() onFailed}) async {
    isLoadingUpdateUser.value = true;
    UserDataEntity? result;
    if (gender != null && status != null) {
      result = await updateUserUc(
        userData.value!.id!,
        UserDataEntity(
          name: name,
          email: email,
          gender: gender,
          status: status,
        ),
      );
    }

    if (result != null) {
      onSuccess();
      isLoadingUpdateUser.value = false;
      return;
    }
    onFailed();
    isLoadingUpdateUser.value = false;
  }

  void deleteUser({required Function() onSuccess, required Function() onFailed}) async {
    isLoadingUpdateUser.value = true;
    final result = await deleteUserUc(userData.value?.id ?? 0);

    if (result) {
      onSuccess();
    } else {
      onFailed();
    }
    isLoadingUpdateUser.value = false;
  }
}
