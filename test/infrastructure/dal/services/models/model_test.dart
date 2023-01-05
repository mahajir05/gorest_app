import 'package:flutter_test/flutter_test.dart';
import 'package:gorest_app/infrastructure/dal/daos/user/models/user_data_model.dart';
import 'package:gorest_app/infrastructure/dal/services/models/base_list_resp.dart';

void main() {
  group('BaseListResp Test', () {
    var jsonArray = [
      {
        'id': 1,
        'name': 'Admin',
        'email': 'admin@email.com',
        'gender': 'L',
        'status': 'active',
      }
    ];
    test('fromJson', () {
      BaseListResp<UserDataModel> resp = BaseListResp<UserDataModel>.fromJson({
        // 'x-pagination-page': ['1'],
        // 'x-pagination-total': ['10'],
      }, jsonArray, UserDataModel.fromJson);
      var result = resp.data;
      expect(result, isA<List<UserDataModel>>());
      expect(result[0], isA<UserDataModel>());
      expect(result[0].toJson(), jsonArray[0]);
    });
  });
}
