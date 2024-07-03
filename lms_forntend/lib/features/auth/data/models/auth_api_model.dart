import 'package:json_annotation/json_annotation.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  final String? fullName;
  final String? email;
  final String? userName;
  final String? phoneNumber;
  final String? password;
  final List<dynamic>? selectedCourse;
  final String? image;

  AuthApiModel({
    this.fullName,
    this.email,
    this.userName,
    this.phoneNumber,
    this.password,
    this.selectedCourse,
    this.image,
  });

  //FROM ENTITY
  factory AuthApiModel.fromEntity(AuthEntity authEntity) {
    return AuthApiModel(
        fullName: authEntity.fullName,
        email: authEntity.email,
        userName: authEntity.userName,
        phoneNumber: authEntity.phoneNumber,
        password: authEntity.password,
        selectedCourse: authEntity.selectedCourse,
        image: authEntity.image,);
  }

  //From JSON
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  //To JSON
  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

    //To Entity
   AuthEntity toEntity() {
    return AuthEntity(
      fullName: fullName,
      email: email,
      userName: userName,
      phoneNumber: phoneNumber,
      password: password,
      selectedCourse: selectedCourse,
      image: image,// Assign the id field
    );
  }
}
