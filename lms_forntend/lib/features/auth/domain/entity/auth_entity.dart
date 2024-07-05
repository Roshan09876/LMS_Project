// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:learn_management_system/features/course/model/course_model.dart';

class AuthEntity extends Equatable {
    final String? fullName;
    final String? email;
    final String? userName;
    final String? phoneNumber;
    final String? password;
    final List<CourseModel>? selectedCourse;
    final String? image;

    AuthEntity({
         this.fullName,
         this.email,
         this.userName,
         this.phoneNumber,
         this.password,
         this.selectedCourse,
         this.image,
    });

     Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'password': password,
      'selectedCourse': selectedCourse?.map((course) => course.toJson()).toList(),
    if (image != null) 'image': image,
    };
  }
    
      @override
      List<Object?> get props => [
        fullName, email, userName, phoneNumber, password, selectedCourse, image
      ];




  AuthEntity copyWith({
    String? fullName,
    String? email,
    String? userName,
    String? phoneNumber,
    String? password,
    List<CourseModel>? selectedCourse,
    String? image,
  }) {
    return AuthEntity(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      image: image ?? this.image,
    );
  }
}
