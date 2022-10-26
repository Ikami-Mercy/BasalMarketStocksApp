import 'package:data/dtos/pagination_dto.dart';
import 'package:data/network/responses/base_response.dart';
import 'package:dependencies/dependencies.dart';

import '../../dtos/stock_data_dto.dart';
part 'stock_data_response.g.dart';

@JsonSerializable()
class StockDataResponse extends BaseResponse{
  final List<StockDataDto>? data;
  final PaginationDto? pagination;

  StockDataResponse(this.data,this.pagination);

  factory StockDataResponse.fromJson(Map<String, dynamic> json) => _$StockDataResponseFromJson(json);


}