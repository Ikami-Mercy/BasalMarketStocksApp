import 'package:dependencies/dependencies.dart';
part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  final int? statusCode;
  final String? error;
  final String? message;


  BaseResponse([this.statusCode, this.error, this.message]);

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);

}