import 'package:flutter_test/flutter_test.dart';
import 'package:gorest_app/domain/features/user/entities/user_data_entity.dart';

void main() {
  test(
    'UserDataEntity is a valid entity',
    () {
      var userData = UserDataEntity(
        id: 1,
        name: 'name',
        email: 'email',
        gender: 'L',
        status: 'password',
      );

      expect(userData.id, isA<int>());
      expect(userData.name, isA<String>());
      expect(userData.email, isA<String>());
      expect(userData.gender, isA<String>());
      expect(userData.status, isA<String>());
    },
  );
}
