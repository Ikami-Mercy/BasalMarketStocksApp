import 'package:data/dtos/pagination_dto.dart';
import 'package:data/network/responses/base_response.dart';

import '../../dtos/stock_data_dto.dart';

class StockDataResponse extends BaseResponse{
  final List<StockDataDto>? data;
  final PaginationDto? pagination;

  StockDataResponse(this.data,this.pagination);

}