import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:learn_management_system/config/common/failure.dart';
import 'package:learn_management_system/config/constant/api_endpoints.dart';
import 'package:learn_management_system/core/network/httpservice.dart';
import 'package:learn_management_system/core/provider/flutter_secure_storage_provider.dart';
import 'package:learn_management_system/features/competedbook/data/model/book_completed_model.dart';

final bookComplterRemoteDatasourceProvider =
    Provider<BookComplterRemoteDatasource>((ref) {
  return BookComplterRemoteDatasource(
      flutterSecureStorage: ref.read(flutterSecureStorageProvider),
      dio: ref.read(httpServiceProvider));
});
class BookComplterRemoteDatasource {
  final FlutterSecureStorage flutterSecureStorage;
  final Dio dio;

  BookComplterRemoteDatasource({
    required this.flutterSecureStorage,
    required this.dio,
  });

  Future<Either<Failure, List<BookCompletedModel>>> getCompletedBook() async {
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
      final url = '${ApiEndpoints.getCompletedBook}/$userID';
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic> &&
            responseData['success'] == true &&
            responseData.containsKey('books')) {
          final List<dynamic> booksJson = responseData['books'];

          final List<BookCompletedModel> bookCompletedModels = booksJson.map((bookJson) {
            return BookCompletedModel(
              id: bookJson['_id'] ?? '',
              title: bookJson['title'] ?? '',
              subtitle: bookJson['subtitle'] ?? '',
              description: bookJson['description'] ?? '',
              image: bookJson['image'] ?? '',
              course: bookJson['course'] ?? '',
              level: bookJson['level'] ?? '',
            );
          }).toList();

          return Right(bookCompletedModels);
        } else {
          return Left(Failure(
            error: 'Failed to fetch completed books',
            statusCode: response.statusCode.toString(),
          ));
        }
      } else {
        return Left(Failure(
          error: 'Failed to fetch completed books',
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioError catch (e) {
      return Left(Failure(error: e.message.toString()));
    } catch (e) {
      return Left(Failure(error: 'An Unexpected Error Occurred'));
    }
  }
}
