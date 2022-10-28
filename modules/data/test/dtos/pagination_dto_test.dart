
import 'package:data/dtos/pagination_dto.dart';
import 'package:data/mappers/pagination_dto_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaginationDto', () {
    test('fromJson generates PaginationDto object', () {
      
      var json = {
        "limit": 30,
        "offset": 0,
        "count": 30,
        "total": 20120
      };

      var pagination = PaginationDto.fromJson(json);

      expect(pagination.limit, 30);
      expect(pagination.offset, 0);
    });

    test('toDomain generates Pagination domain object', () {
      var paginationDto =  PaginationDto(
          limit:30,offset:0,count:30,total:20120
      );

      PaginationDtoMapper paginationDtoMapper = PaginationDtoMapper();
      var pagination = paginationDtoMapper.mapFromDto(paginationDto);
      expect(pagination.limit, 30);
      expect(pagination.count, 30);
    });
  });
}
