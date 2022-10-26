import 'package:domain/models/pagination.dart';

import '../dtos/pagination_dto.dart';
import 'dto_mapper.dart';

class PaginationDtoMapper extends DtoMapper<PaginationDto, Pagination> {
  @override
  Pagination mapFromDto(PaginationDto dto) {
    return Pagination(
      limit: dto.limit,
      offset: dto.offset ?? 0,
      count: dto.count ?? 0,
      total: dto.total ?? 0,
    );
  }

  @override
  PaginationDto mapToDto(Pagination domain) {
    return PaginationDto(
      limit: domain.limit,
      offset: domain.offset ?? 0,
      count: domain.count ?? 0,
      total: domain.total ?? 0,
    );
  }

  List<Pagination> mapFromDtoListToDomain(List<PaginationDto> dtoList) {
    return dtoList.map((e) => mapFromDto(e)).toList();
  }
}
