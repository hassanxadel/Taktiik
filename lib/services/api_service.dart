import 'package:dio/dio.dart';
import '../core/constants/app_constants.dart';
import '../core/errors/exceptions.dart';

class ApiService {
  final Dio _dio;

  ApiService() : _dio = Dio(BaseOptions(
    baseUrl: AppConstants.apiBaseUrl,
    headers: AppConstants.apiHeaders,
    connectTimeout: const Duration(seconds: 10),
  ));

  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: params,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode != 200) {
      throw ServerException('Failed to load data: ${response.statusCode}');
    }
    return response.data as Map<String, dynamic>;
  }

  Never _handleError(DioException e) {
    if (e.response?.statusCode == 401) {
      throw ServerException('Invalid API key');
    }
    if (e.type == DioExceptionType.connectionTimeout) {
      throw ServerException('Connection timeout');
    }
    throw ServerException(e.message ?? 'Network error occurred');
  }
}