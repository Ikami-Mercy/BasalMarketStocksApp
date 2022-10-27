import 'package:domain/models/stock_data.dart';

import '../dtos/stock_data_dto.dart';
import 'dto_mapper.dart';

class StockDataDtoMapper extends DtoMapper<StockDataDto, StockData> {
  @override
  StockData mapFromDto(StockDataDto dto) {
    return StockData(
      open: dto.open,
      high: dto.high ,
      low: dto.low ,
      last: dto.last,
      close: dto.close,
      volume: dto.volume,
      date: dto.date ?? '',
      symbol: dto.symbol ?? '',
      exchange: dto.exchange ?? '',
    );
  }

  @override
  StockDataDto mapToDto(StockData domain) {
    return StockDataDto(
      open: domain.open,
      high: domain.high,
      low: domain.low,
      last: domain.last,
      close: domain.close,
      volume: domain.volume,
      date: domain.date ?? '',
      symbol: domain.symbol ?? '',
      exchange: domain.exchange ?? '',
    );
  }

  List<StockData> mapFromDtoListToDomain(List<StockDataDto> dtoList) {
    return dtoList.map((e) => mapFromDto(e)).toList();
  }
}
