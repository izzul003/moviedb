import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppNetworkClient {
  static BaseOptions options = BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/',
    connectTimeout: const Duration(seconds: 30),
  );

  static final Dio dio = Dio(options)
    ..interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add the access token to the request header
          String? token = _getToken();
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            String? token = _getToken();

            if (token != null ) {

            }
          }

          if (e.response != null) {
            debugPrint('Error HEADERS ${e.requestOptions.headers}');
            debugPrint('Error METHOD ${e.requestOptions.method}');
            debugPrint('Error CALLING ${e.requestOptions.path}');
            debugPrint('Error DATA ${e.requestOptions.data}');
            debugPrint('Error QUERY ${e.requestOptions.queryParameters}');
          } else {
            // Something happened in setting up or sending the request that triggered an Error
            debugPrint('CALLING ${e.requestOptions}');
            debugPrint(e.message);
          }

          if (e.toString().contains('Failed host lookup')) {

          }

          return handler.next(e);
        },
      ),
    ]);

  static String? _getToken() {
    String? token;

    token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNTIzZjM2Y2ViOGVjYmJkMTJlMDRlMWFiNGY1NDQ2YyIsIm5iZiI6MTcyMTc5NzkwNi40OTA1NzQsInN1YiI6IjY2YTA4YzFmMTU1ZmUwYWZkNTBiZTZlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BHvp3lH_aH6e94jv3IpnQv1fGQz2Id0bq1tZu2fM2IQ';

    if (token != null) {
      return token = token;
    } else {
      return null;
    }
  }
}