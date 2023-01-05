import 'dart:async';

import 'package:get/get.dart';

import '../../../domain/features/user/entities/pagination_entity.dart';
import '../../../domain/features/user/entities/user_data_entity.dart';
import '../../../domain/features/user/use_cases/get_users_uc.dart';

class HomeController extends GetxController {
  final GetUsersUc getUsersUc;
  HomeController({required this.getUsersUc});

  RxBool isInifiniteListLoading = false.obs;
  Rx<PaginationEntity<UserDataEntity>?> users = Rxn<PaginationEntity<UserDataEntity>>();

  RxBool isSearching = false.obs;
  RxBool isSearchingLoading = false.obs;
  Rx<List<UserDataEntity>?> usersFromSearching = Rxn<List<UserDataEntity>>();

  @override
  void onInit() {
    super.onInit();

    getUsers();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  Future getUsers({int? page, int? perPage, bool isRefresh = false}) async {
    isInifiniteListLoading.value = true;
    final result = await getUsersUc(page ?? ((users.value?.page ?? 0) + 1), (perPage ?? 10));
    if (isRefresh) {
      users.value = result;
    } else {
      int? totalDataOnApi = result.totalDataOnApi;
      if (result.data.isEmpty) {
        totalDataOnApi = users.value?.data.length;
      }
      users.value = PaginationEntity(page: result.page, totalDataOnApi: totalDataOnApi, data: [
        ...(users.value?.data ?? []),
        ...result.data,
      ]);
    }
    isInifiniteListLoading.value = false;
  }

  void search(String keyword) async {
    if (keyword.isNotEmpty) {
      isSearching.value = true;
      isSearchingLoading.value = true;
      final resultFromLocal = users.value?.data
          .where((element) =>
              (element.name ?? '').toLowerCase().contains(keyword.toLowerCase()) ||
              (element.email ?? '').toLowerCase().contains(keyword.toLowerCase()))
          .toList();
      if ((resultFromLocal ?? []).isEmpty && users.value?.isMaxData != true) {
        await getUsers(perPage: 100);
        isSearchingLoading.value = false;
        if (isSearching.value) search(keyword);
      } else {
        usersFromSearching.value = resultFromLocal;
        isSearchingLoading.value = false;
      }
    }
  }

  void cancelSearch() {
    isSearching.value = false;
    isSearchingLoading.value = false;
    usersFromSearching.value = [];
  }
}
