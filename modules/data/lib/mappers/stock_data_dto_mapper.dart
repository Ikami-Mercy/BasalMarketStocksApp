import 'package:domain/models/stock_data.dart';

import '../dtos/stock_data_dto.dart';
import 'dto_mapper.dart';

class StockDataDtoMapper extends DtoMapper<StockDataDto, StockData> {
  @override
  StockData mapFromDto(StockDataDto dto) {
    return StockData(
      open: dto.open,
      high: dto.high ?? 0,
      last: dto.last ?? 0,
      close: dto.close ?? 0,
      volume: dto.volume ?? 0,
      date: dto.date ?? '',
      symbol: dto.symbol ?? '',
      exchange: dto.exchange ?? '',
    );
  }

  @override
  StockDataDto mapToDto(StockData domain) {
    return StockDataDto(
      open: domain.open,
      high: domain.high ?? 0,
      last: domain.last ?? 0,
      close: domain.close ?? 0,
      volume: domain.volume ?? 0,
      date: domain.date ?? '',
      symbol: domain.symbol ?? '',
      exchange: domain.exchange ?? '',
    );
  }

  List<StockData> mapFromDtoListToDomain(List<StockDataDto> dtoList) {
    return dtoList.map((e) => mapFromDto(e)).toList();
  }
}
