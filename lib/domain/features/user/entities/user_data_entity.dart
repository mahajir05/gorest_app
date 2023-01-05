import 'package:equatable/equatable.dart';

class UserDataEntity extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? gender;
  final String? status;

  const UserDataEntity({this.id, this.name, this.email, this.gender, this.status});

  @override
  List<Object?> get props => [id, name, email, gender, status];
}
