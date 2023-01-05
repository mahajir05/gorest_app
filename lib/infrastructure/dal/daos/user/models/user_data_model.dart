import '../../../../../domain/features/user/entities/user_data_entity.dart';

class UserDataModel extends UserDataEntity {
  const UserDataModel({
    int? id,
    String? name,
    String? email,
    String? gender,
    String? status,
  }) : super(
          id: id,
          name: name,
          email: email,
          gender: gender,
          status: status,
        );

  UserDataModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          gender: json['gender'],
          status: json['status'],
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = super.id;
    data['name'] = super.name;
    data['email'] = super.email;
    data['gender'] = super.gender;
    data['status'] = super.status;
    return data;
  }
}
