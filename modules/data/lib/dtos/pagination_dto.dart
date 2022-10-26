import 'package:dependencies/dependencies.dart';

part 'pagination_dto.g.dart';
@JsonSerializable()
class PaginationDto {
  int? limit;
  int? offset;
  int? count;
  int? total;

  PaginationDto({this.limit, this.offset, this.count, this.total});

  factory PaginationDto.fromJson(Map<String, dynamic> json) => _$PaginationDtoFromJson(json);

}
