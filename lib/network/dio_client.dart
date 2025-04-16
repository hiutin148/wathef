import 'package:dio/dio.dart';
import 'package:wathef/core/consts/api_consts.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        queryParameters: {
          'client_id': ApiConstants.clientId,
          'format': 'json',
        },
      ),
    );

    // (Tùy chọn) Thêm Interceptors để log request/response
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: print, // Hoặc sử dụng logger
    ));
  }

  Dio get dio => _dio;
}
