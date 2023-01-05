import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../domain/core/constants/validators.dart';
import '../../domain/core/interfaces/snackbar_utils.dart';
import '../../domain/core/interfaces/widget_utils.dart';
import 'controllers/detail.controller.dart';

class DetailScreen extends GetView<DetailController> {
  DetailScreen({Key? key}) : super(key: key);

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.userData.value != null)
                          WidgetUtils.labelText(
                            title: 'ID',
                            value: controller.userData.value?.id,
                          ),
                        WidgetUtils.textField(
                          hint: controller.userData.value?.name ?? 'Name',
                          icon: Icons.ac_unit,
                          showicon: false,
                          validator: (value) {
                            return value!.isEmpty ? "Please Enter A Name" : null;
                          },
                          textEditingController: _nameTextController,
                        ),
                        WidgetUtils.textField(
                          hint: controller.userData.value?.email ?? 'Email',
                          icon: Icons.ac_unit,
                          showicon: false,
                          validator: (value) {
                            return !Validators.isValidEmail(value!) ? 'Enter a valid email' : null;
                          },
                          textEditingController: _emailTextController,
                        ),
                        const Text(
                          'Gender',
                        ),
                        Obx(
                          () => WidgetUtils.radio<String?>(
                            group: controller.gender.value,
                            dataList: ['male', 'female'],
                            title: (data) => Text(data ?? '-'),
                            onChanged: (value) {
                              controller.gender.value = value;
                            },
                          ),
                        ),
                        // if (controller.userData.value != null)
                        //   WidgetUtils.labelText(
                        //     title: 'Status',
                        //     value: controller.userData.value?.status,
                        //   ),
                        const Text(
                          'Status',
                        ),
                        Obx(
                          () => WidgetUtils.radio<String?>(
                            group: controller.status.value,
                            dataList: ['active', 'inactive'],
                            title: (data) => Text(data ?? '-'),
                            onChanged: (value) {
                              controller.status.value = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => controller.userData.value != null ? _buttonEdit() : _buttonAdd(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonEdit() {
    return Obx(() => controller.isLoadingUpdateUser.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              SizedBox(
                  width: Get.width,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_nameTextController.text.isEmpty) {
                          _nameTextController.text = controller.userData.value?.name ?? '';
                        }
                        if (_emailTextController.text.isEmpty) {
                          _emailTextController.text = controller.userData.value?.email ?? '';
                        }
                        controller.updateUser(
                          name: _nameTextController.text,
                          email: _emailTextController.text,
                          gender: controller.gender.value,
                          status: controller.status.value,
                          onSuccess: () {
                            Get.back();
                            SnackbarUtils.generalSnackbar(
                              title: 'Success',
                              message: 'update user success',
                              colorText: Colors.green,
                            );
                          },
                          onFailed: () {
                            SnackbarUtils.generalSnackbar(
                              title: 'Failed',
                              message: 'update user failed',
                              colorText: Colors.red,
                            );
                          },
                        );
                      },
                      child: const Text('Save'))),
              const SizedBox(height: 8),
              SizedBox(
                  width: Get.width,
                  child: OutlinedButton(
                      onPressed: () {
                        controller.deleteUser(
                          onSuccess: () {
                            Get.back();
                            SnackbarUtils.generalSnackbar(
                              title: 'Success',
                              message: 'delete user success',
                              colorText: Colors.green,
                            );
                          },
                          onFailed: () {
                            SnackbarUtils.generalSnackbar(
                              title: 'Failed',
                              message: 'delete user failed',
                              colorText: Colors.red,
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Delete User',
                        style: TextStyle(color: Colors.red),
                      ))),
            ],
          ));
  }

  Widget _buttonAdd() {
    return Obx(
      () => controller.isLoadingAddUser.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              width: Get.width,
              child: ElevatedButton(
                onPressed: () {
                  controller.addUser(
                    name: _nameTextController.text,
                    email: _emailTextController.text,
                    gender: controller.gender.value,
                    status: controller.status.value,
                    onSuccess: () {
                      Get.back();
                      SnackbarUtils.generalSnackbar(
                        title: 'Success',
                        message: 'add user success',
                        colorText: Colors.green,
                      );
                    },
                    onFailed: () {
                      SnackbarUtils.generalSnackbar(
                        title: 'Failed',
                        message: 'add user failed',
                        colorText: Colors.red,
                      );
                    },
                  );
                },
                child: const Text('Create User'),
              ),
            ),
    );
  }
}
