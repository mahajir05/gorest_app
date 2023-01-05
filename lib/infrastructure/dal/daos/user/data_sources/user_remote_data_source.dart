import '../../../../../config.dart';
import '../../../../../domain/core/constants/api_path.dart';
import '../../../../../domain/core/interfaces/print_utils.dart';
import '../../../services/api_service.dart';
import '../../../services/models/base_list_resp.dart';
import '../models/user_data_model.dart';

abstract class IUserRemoteDataSource {
  Future<BaseListResp<UserDataModel>> getUsers({int? page, int? perPage});
  Future<UserDataModel?> getUserDetail(int id);
  Future<UserDataModel?> addUser(UserDataModel userData);
  Future<UserDataModel?> updateUser(int id, UserDataModel userData);
  Future<bool> deleteUser(int id);
}

class UserRemoteDataSource implements IUserRemoteDataSource {
  final ApiService apiService;

  UserRemoteDataSource({required this.apiService});

  @override
  Future<BaseListResp<UserDataModel>> getUsers({int? page, int? perPage}) async {
    try {
      final resp = await apiService.baseUrl(ConfigEnvironments.getEnvironments()['url']!).tokenBearer(GOREST_TOKEN).get(
            apiPath: '${ApiPath.users}?page=$page&per_page=$perPage',
          );
      switch (resp.statusCode) {
        case 200:
          return BaseListResp.fromJson(resp.headers.map, resp.data, UserDataModel.fromJson);
        default:
          return BaseListResp.fromJson({}, [], UserDataModel.fromJson);
      }
    } catch (e) {
      printRed('[${this}][getUsers] catch: $e');
      return BaseListResp(data: []);
    }
  }

  @override
  Future<UserDataModel?> getUserDetail(int id) async {
    try {
      final resp = await apiService.baseUrl(ConfigEnvironments.getEnvironments()['url']!).tokenBearer(GOREST_TOKEN).get(
            apiPath: '${ApiPath.users}/$id',
          );
      switch (resp.statusCode) {
        case 200:
          return UserDataModel.fromJson(resp.data);
        default:
          return null;
      }
    } catch (e) {
      printRed('[${this}][getUserDetail] catch: $e');
      return null;
    }
  }

  @override
  Future<UserDataModel?> addUser(UserDataModel userData) async {
    try {
      final resp =
          await apiService.baseUrl(ConfigEnvironments.getEnvironments()['url']!).tokenBearer(GOREST_TOKEN).post(
                apiPath: ApiPath.users,
                request: userData.toJson(),
              );
      switch (resp.statusCode) {
        case 201:
          var result = UserDataModel.fromJson(resp.data);
          return result;
        default:
          return null;
      }
    } catch (e) {
      printRed('[${this}][addUser] catch: $e');
      return null;
    }
  }

  @override
  Future<UserDataModel?> updateUser(int id, UserDataModel userData) async {
    try {
      final resp = await apiService.baseUrl(ConfigEnvironments.getEnvironments()['url']!).tokenBearer(GOREST_TOKEN).put(
            apiPath: '${ApiPath.users}/$id',
            request: userData.toJson(),
            useFormData: false,
          );
      switch (resp.statusCode) {
        case 200:
          return UserDataModel.fromJson(resp.data);
        default:
          return null;
      }
    } catch (e) {
      printRed('[${this}][updateUser] catch: $e');
      return null;
    }
  }

  @override
  Future<bool> deleteUser(int id) async {
    try {
      final resp =
          await apiService.baseUrl(ConfigEnvironments.getEnvironments()['url']!).tokenBearer(GOREST_TOKEN).delete(
                apiPath: '${ApiPath.users}/$id',
              );
      switch (resp.statusCode) {
        case 204:
          return true;
        default:
          return false;
      }
    } catch (e) {
      printRed('[${this}][deleteUser] catch: $e');
      return false;
    }
  }
}
