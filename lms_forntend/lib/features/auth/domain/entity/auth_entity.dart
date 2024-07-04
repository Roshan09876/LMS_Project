// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
    final String? fullName;
    final String? email;
    final String? userName;
    final String? phoneNumber;
    final String? password;
    final List<dynamic>? selectedCourse;
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
      if (selectedCourse != null) 'selectedCourse': selectedCourse,
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
    List<dynamic>? selectedCourse,
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
