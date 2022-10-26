import 'package:data/di/injection.dart';
import 'package:dependencies/dependencies.dart';

import '../network/api_service.dart';
import '../network/interceptors/logger_interceptor.dart';



@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dioClient {
    var dio = Dio();
    dio.interceptors.add(LoggerInterceptor());
    return dio;
  }

  @lazySingleton
  ApiService get apiService =>
      ApiService(getIt<Dio>(), baseUrl: dotenv.env['BASE_URL'] ?? '');

}

