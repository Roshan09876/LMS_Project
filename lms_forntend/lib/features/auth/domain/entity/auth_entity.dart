// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:learn_management_system/features/course/model/course_model.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String? fullName;
  final String? email;
  final String? userName;
  final String? phoneNumber;
  final String? password;
  final bool? isAdmin;
  final List<CourseModel>? selectedCourse; // Changed to CourseModel
  final String? image;

  AuthEntity({
    this.id,
    this.fullName,
    this.email,
    this.userName,
    this.phoneNumber,
    this.password,
    this.isAdmin,
    this.selectedCourse,
    this.image,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        userName,
        phoneNumber,
        password,
        isAdmin,
        selectedCourse,
        image,
      ];

  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      isAdmin: json['isAdmin'],
      selectedCourse: json['selectedCourse'] != null
          ? (json['selectedCourse'] as List<dynamic>)
              .map((courseJson) => CourseModel.fromJson(courseJson))
              .toList()
          : null,
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'password': password,
      'isAdmin': isAdmin,
      'selectedCourse': selectedCourse?.map((course) => course.toJson()).toList(),
      'image': image,
    };
  }

  AuthEntity copyWith({
    String? id,
    String? fullName,
    String? email,
    String? userName,
    String? phoneNumber,
    String? password,
    bool? isAdmin,
    List<CourseModel>? selectedCourse, // Changed to CourseModel
    String? image,
  }) {
    return AuthEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      isAdmin: isAdmin ?? this.isAdmin,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      image: image ?? this.image,
    );
  }
}
