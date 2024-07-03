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

}