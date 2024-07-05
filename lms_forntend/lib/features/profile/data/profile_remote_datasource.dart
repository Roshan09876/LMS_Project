import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:learn_management_system/config/common/failure.dart';
import 'package:learn_management_system/config/constant/api_endpoints.dart';
import 'package:learn_management_system/core/network/httpservice.dart';
import 'package:learn_management_system/core/provider/flutter_secure_storage_provider.dart';
import 'package:learn_management_system/features/auth/data/models/auth_api_model.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';
import 'package:learn_management_system/features/course/model/course_model.dart';

final profileRemoteDatasourceProvider =
    Provider<ProfileRemoteDatasource>((ref) {
  return ProfileRemoteDatasource(
      flutterSecureStorage: ref.read(flutterSecureStorageProvider),
      dio: ref.read(httpServiceProvider));
});

class ProfileRemoteDatasource {
  final FlutterSecureStorage flutterSecureStorage;
  final Dio dio;

  ProfileRemoteDatasource(
      {required this.flutterSecureStorage, required this.dio});

Future<Either<Failure, List<AuthEntity>>> getProfile() async {
  try {
    final token = await flutterSecureStorage.read(key: 'token');
    if (token == null) {
      return Left(Failure(error: 'An Unexpected Error Occurred'));
    }
    final decodedToken = JwtDecoder.decode(token);
    final userID = decodedToken['id'];
    if (userID == null) {
      return Left(Failure(error: 'An Unexpected Error Occurred'));
    }
    final url = '${ApiEndpoints.getProfile}/$userID';
    Response response = await dio.get(
      url,
      queryParameters: {'id': userID},
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = response.data;
      if (responseData is Map<String, dynamic> &&
          responseData['success'] == true &&
          responseData.containsKey('user')) {
        var userJSON = responseData['user'] as Map<String, dynamic>;
        List<dynamic> selectedCourseIds = userJSON['selectedCourse'] ?? [];
        List<CourseModel> selectedCourses = selectedCourseIds.map((courseId) {
          // Assuming CourseModel has a constructor that takes an ID
          return CourseModel(id: courseId);
        }).toList();

        AuthEntity user = AuthEntity(
          fullName: userJSON['fullName'],
          email: userJSON['email'],
          userName: userJSON['userName'],
          phoneNumber: userJSON['phoneNumber'],
          password: userJSON['password'],
          selectedCourse: userJSON['selectedCourse'],
          image: userJSON['image'],
        );
        return Right([user]);
      } else {
        return Left(Failure(error: 'User data not found in response'));
      }
    } else {
      return Left(Failure(error: 'Failed to load profile'));
    }
  } catch (e) {
    return Left(Failure(error: e.toString()));
  }
}


  Future<Either<Failure, bool>> updateProfile(AuthEntity authEntity) async {
    try {
      final token = await flutterSecureStorage.read(key: 'token');
      if (token == null) {
        return Left(Failure(error: 'An Unexpected error occured'));
      }
      final decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['id'];
      if (userId == null) {
        return Left(Failure(error: 'An Unexpected error occured'));
      }
      final url = '${ApiEndpoints.updateProfile}/$userId';
      final response = await dio.put(
        url,
        queryParameters: {'id': userId},
        data: authEntity.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        print(responseData);
        return const Right(true);
      } else {
        return Left(Failure(
            error: response.statusMessage ?? 'Failed to Update Details',
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response!.data['message']));
    }

  }
}
