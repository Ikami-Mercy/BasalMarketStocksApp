import 'package:data/blocs/stocks/stock_state.dart';
import 'package:data/mappers/stock_data_dto_mapper.dart';
import 'package:dependencies/dependencies.dart';
import 'package:domain/repositories/stocks_repository.dart';

class StockCubit extends Cubit<StockState>{
  final IStockRepository _stockRepository;
  StockDataDtoMapper dtoMapper;
  StockCubit(this.dtoMapper,this._stockRepository): super(InitialStockState());

}