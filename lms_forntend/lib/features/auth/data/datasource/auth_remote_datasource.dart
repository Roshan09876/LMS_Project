import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learn_management_system/config/common/failure.dart';
import 'package:learn_management_system/config/constant/api_endpoints.dart';
import 'package:learn_management_system/core/network/httpservice.dart';
import 'package:learn_management_system/core/provider/flutter_secure_storage_provider.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDatasource>((ref) =>
    AuthRemoteDatasource(
        dio: ref.read(httpServiceProvider),
        flutterSecureStorage: ref.read(flutterSecureStorageProvider)));

class AuthRemoteDatasource {
  final Dio dio;
  final FlutterSecureStorage flutterSecureStorage;
  AuthRemoteDatasource({required this.dio, required this.flutterSecureStorage});

  Future<Either<Failure, bool>> register(AuthEntity authEntity) async {
    try {
      final url = ApiEndpoints.register;
      final response = await dio.post(url, data: authEntity.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(true);
      } else {
        return Left(Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.error.toString(),
      ));
    }
  }

  Future<Either<Failure, bool>> login(String userName, String password) async {
    try {
      final url = ApiEndpoints.login;
      Response response = await dio.post(url, data: {
        "userName": userName,
        "password": password,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data['token'];
       final userName = response.data['userData']['userName'];
        final password = response.data['userData']['password'];
        await flutterSecureStorage.write(key: "token", value: token);
        await flutterSecureStorage.write(key: 'userName', value: userName);
        await flutterSecureStorage.write(key: 'password', value: password);
        return Right(true);
      } else {
        return Left(Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
