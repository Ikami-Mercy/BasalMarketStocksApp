import 'package:data/blocs/stocks/stock_state.dart';
import 'package:data/local/dao/stock_dao.dart';
import 'package:data/mappers/stock_data_dto_mapper.dart';
import 'package:data/utils/constants.dart';
import 'package:dependencies/dependencies.dart';
import 'package:domain/models/stock_data.dart';
import 'package:domain/repositories/stocks_repository.dart';

@injectable
class StockCubit extends Cubit<StockState> {
  final IStockRepository _stockRepository;
  final StockDao _stockDao;
  List<StockData> locallySavedStocks = [];
  List<StockData> filteredStock = [];
  StockDataDtoMapper dtoMapper = StockDataDtoMapper();
  String key = dotenv.env['MARKET_STACK_API_KEY'] ?? 'testKey';

  StockCubit(this._stockRepository, this._stockDao)
      : super(InitialStockState());

  void loadStockMarketData() async {
    loadLocalStockMarketData();
    try {
      var response = await _stockRepository.fetchStockMarketData(key,
          Constants.PAGINATION_PAGE_SIZE, Constants.stockMarketSymbolsArray);
      if (response.success) {
        Fimber.i(
            'SuccessStockState emitted and page count is: ${response.extras}');
        emit(SuccessStockState(stockData: response.data!));
      }
      else{
        if (locallySavedStocks.isEmpty) {
          emit(ErrorStockState(errorMessage: response.error??'Unexpected error occurred'));
        }
      }
    } catch (e) {
      Fimber.e("Error fetching Stock Market Data: $e", ex: e);
      if (locallySavedStocks.isEmpty) {
        emit(const ErrorStockState(errorMessage:'Unexpected error occurred'));
      }
    }
  }

  void loadLocalStockMarketData() async {
    emit(LoadingStockState());
    var savedStockMarketData = await _stockDao.getStockData();
    locallySavedStocks = dtoMapper.mapFromDtoListToDomain(savedStockMarketData);
    if (locallySavedStocks.isNotEmpty) {
      emit(SuccessStockState(stockData: locallySavedStocks));
    }
  }

  void filterStockDataByDate(String startDate, String endDate) async {
    try {
      emit(LoadingStockState());
      Fimber.i("startDate is $startDate and endDate $endDate");
      var filteredStockData =
          await _stockDao.filterStockDataByDate(startDate, endDate);
      filteredStock = dtoMapper.mapFromDtoListToDomain(filteredStockData);
      Fimber.i("filteredStock is $filteredStock");
      if (filteredStock.isNotEmpty) {
        emit(SuccessFilteredStockState(stockData: filteredStock));
      } else {
        emit(EmptyStockFilteredState());
      }
    } catch (e) {
      Fimber.e("Error filtering Stock Data by date: $e", ex: e);
      emit(const ErrorStockState(errorMessage:'Unexpected error occurred'));
    }
  }
}
