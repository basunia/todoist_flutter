import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Http {
  static Dio? dio;

  static Dio? getDio() {
    if (dio == null) {
      dio = new Dio();
      dio?.options.baseUrl = "https://staging-data.gtaf.org/api/";
      dio?.options.connectTimeout = 5000; //5s
      dio?.options.receiveTimeout = 3000;
      dio?.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
      dio?.options.headers["Api-Key"] = "7z*)_-iulu_6j20!h@r8lw8g4)";
      dio?.options.headers["Accept-Language"] = 'bn';
    }

    return dio;
  }
}
