import 'package:dependencies/dependencies.dart';
import 'package:floor/floor.dart';

part 'stock_data_dto.g.dart';

@entity
@JsonSerializable()
class StockDataDto {
  @PrimaryKey(autoGenerate: true)
  int? id;
  double? open;
  double? high;
  double? low;
  double? last;
  double? close;
  double? volume;
  String? date;
  String? symbol;
  String? exchange;

  StockDataDto(
      {this.open,
      this.high,
      this.low,
      this.last,
      this.close,
      this.volume,
      this.date,
      this.symbol,
      this.exchange});

  factory StockDataDto.fromJson(Map<String, dynamic> json) => _$StockDataDtoFromJson(json);

}
