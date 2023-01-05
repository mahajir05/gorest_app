import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../domain/features/user/entities/user_data_entity.dart';
import '../../infrastructure/navigation/routes.dart';
import 'controllers/home.controller.dart';
import 'views/infinite_list_view.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  final _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchTextController,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: "search user here..",
                        contentPadding: const EdgeInsets.only(left: 16.0, top: 16.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isEmpty) controller.cancelSearch();
                      },
                    ),
                  ),
                  Obx(
                    () => IconButton(
                      onPressed: controller.isSearchingLoading.value
                          ? null
                          : () {
                              controller.search(_searchTextController.text);
                            },
                      icon: Icon(
                        Icons.search,
                        color: controller.isSearchingLoading.value ? Colors.grey : Colors.blue,
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.isSearching.value
                        ? IconButton(
                            onPressed: () {
                              _searchTextController.text = '';
                              controller.cancelSearch();
                            },
                            icon: const Icon(
                              Icons.search_off,
                              color: Colors.red,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.getUsers(page: 1, isRefresh: true);
                  },
                  child: Obx(
                    () {
                      if (controller.isSearching.value) {
                        if (controller.isSearchingLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if ((controller.usersFromSearching.value ?? []).isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('no data'),
                              TextButton(
                                onPressed: () {
                                  _searchTextController.text = '';
                                  controller.cancelSearch();
                                },
                                child: const Text('cancel search'),
                              ),
                            ],
                          );
                        }
                        return InfiniteListView<UserDataEntity>(
                          isLoading: controller.isInifiniteListLoading.value,
                          items: controller.usersFromSearching.value ?? [],
                          isMaxData: true,
                          onItemTap: (data) {
                            Get.toNamed(
                              Routes.DETAIL,
                              arguments: [false, data],
                            );
                          },
                        );
                      }

                      return InfiniteListView<UserDataEntity>(
                        isLoading: controller.isInifiniteListLoading.value,
                        items: controller.users.value?.data ?? [],
                        isMaxData: controller.users.value?.isMaxData ?? false,
                        onMaxScroll: controller.getUsers,
                        onItemTap: (data) {
                          Get.toNamed(
                            Routes.DETAIL,
                            arguments: [false, data],
                          );
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(
              Routes.DETAIL,
              arguments: [false, null],
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}
