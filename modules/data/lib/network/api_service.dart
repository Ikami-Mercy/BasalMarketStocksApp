import 'package:data/network/responses/stock_data_response.dart';
import 'package:dependencies/dependencies.dart';

import 'apis.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService{
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(Apis.FETCH_MARKET_STOCK_EOD)
  Future<StockDataResponse> fetchMarketStockData(
      @Path("access_key") String key, @Path("limit") int limit,@Path("symbols") String symbols);
}