import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Http {
  static Dio? _dio;

  static Dio? getDio() {
    if (_dio == null) {
      _dio = new Dio();
      _dio?.options.baseUrl = "https://staging-data.gtaf.org/api/";
      _dio?.options.connectTimeout = 5000; //5s
      _dio?.options.receiveTimeout = 3000;
      _dio?.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
      _dio?.options.headers["Api-Key"] = "7z*)_-iulu_6j20!h@r8lw8g4)";
      _dio?.options.headers["Accept-Language"] = 'bn';
    }

    return _dio;
  }
}
