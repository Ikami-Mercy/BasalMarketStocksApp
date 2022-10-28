import 'package:data/dtos/pagination_dto.dart';
import 'package:data/mappers/pagination_dto_mapper.dart';
import 'package:domain/models/pagination.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('Pagination Mapper', () {
    late PaginationDto paginationDto;
    late Pagination pagination;
    late PaginationDtoMapper paginationDtoMapper;

    setUp(() {
      pagination = Pagination(
          limit: 30,
          offset: 0,
          count: 30,
          total: 20120
      );

      paginationDto = PaginationDto(
          limit: 30,
          offset: 0,
          count: 30,
          total: 20120
      );

      paginationDtoMapper = PaginationDtoMapper();
    });

    test('map to dto should return object with same values', () {
      var dto = paginationDtoMapper.mapToDto(pagination);
      expect(dto.count, 30);
      expect(dto.total, 20120);
    });

    test('map from dto should return object with same values', () {
      var pagination = paginationDtoMapper.mapFromDto(paginationDto);
      expect(pagination.count, 30);
      expect(pagination.total, 20120);
    });

  });
}