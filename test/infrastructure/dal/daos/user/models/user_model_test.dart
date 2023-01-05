import 'package:flutter_test/flutter_test.dart';
import 'package:gorest_app/domain/features/user/entities/user_data_entity.dart';
import 'package:gorest_app/infrastructure/dal/daos/user/models/user_data_model.dart';

void main() {
  group('UserDataModel Test', () {
    late Map<String, dynamic> jsonData;
    late UserDataModel userDataModel;

    setUpAll(() {
      jsonData = {
        'id': 1,
        'name': 'Admin',
        'email': 'admin@email.com',
        'gender': 'L',
        'status': 'active',
      };

      userDataModel = const UserDataModel(
        id: 1,
        name: 'Admin',
        email: 'admin@email.com',
        gender: 'L',
        status: 'active',
      );
    });

    test('from json', () {
      var result = UserDataModel.fromJson(jsonData);
      expect(result, isA<UserDataModel>());
      expect(result, isA<UserDataEntity>());
      expect(result.id, equals(1));
      expect(result.name, equals('Admin'));
      expect(result.email, equals('admin@email.com'));
      expect(result.gender, equals('L'));
      expect(result.status, equals('active'));
      expect(result, equals(userDataModel));
    });

    test('to json', () {
      expect(userDataModel, isA<UserDataModel>());
      expect(userDataModel, isA<UserDataEntity>());
      var result = userDataModel.toJson();
      expect(result, equals(jsonData));
    });
  });
}
