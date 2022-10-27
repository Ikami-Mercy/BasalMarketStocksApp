import 'package:data/blocs/stocks/stock_state.dart';
import 'package:data/mappers/stock_data_dto_mapper.dart';
import 'package:data/utils/constants.dart';
import 'package:dependencies/dependencies.dart';
import 'package:domain/repositories/stocks_repository.dart';

@injectable
class StockCubit extends Cubit<StockState> {
  final IStockRepository _stockRepository;
  StockDataDtoMapper dtoMapper = StockDataDtoMapper();
  String key = dotenv.env['MARKET_STACK_API_KEY'] ?? 'testKey';

  StockCubit(this._stockRepository)
      : super(InitialStockState());

  void loadStockMarketData() async {
    emit(LoadingStockState());
    Fimber.i('LoadingStockState emitted');
    try {
      var response = await _stockRepository.fetchStockMarketData(
          key, Constants.PAGINATION_PAGE_SIZE,Constants.stockMarketSymbolsArray);
      if (response.success) {
        Fimber.i('SuccessStockState emitted and page count is: ${response.extras}');
        emit(SuccessStockState(stockData: response.data!));
      }
    } catch (e) {
      Fimber.e("Error fetching Stock Market Data: $e", ex: e);
      emit(ErrorStockState());
    }
  }
}