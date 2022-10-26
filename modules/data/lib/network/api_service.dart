import 'package:dependencies/dependencies.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService{
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

}