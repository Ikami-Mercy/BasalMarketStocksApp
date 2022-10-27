import 'package:data/di/injection.dart';
import 'package:data/local/dao/stock_dao.dart';
import 'package:dependencies/dependencies.dart';

import '../local/app_database.dart';
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
@module
abstract class DatabaseModule {
  @preResolve
  Future<AppDatabase> get database async {
    return await $FloorAppDatabase
        .databaseBuilder(dotenv.env['DB_NAME'] ?? 'stock')
        .build();
  }

  @lazySingleton
  StockDao get stockDao => getIt<AppDatabase>().stockDao;

}
