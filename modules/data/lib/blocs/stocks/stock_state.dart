import 'package:dependencies/dependencies.dart';
import 'package:domain/models/stock_data.dart';

abstract class StockState extends Equatable{
  const StockState();
}

class InitialStockState extends StockState{
  @override
  List<Object?> get props => [];

}

class LoadingStockState extends StockState{
  @override
  List<Object?> get props => [];
}

class SuccessStockState extends StockState{

  final List<StockData> stockData;

  const SuccessStockState({required this.stockData});
  @override
  List<Object?> get props => [stockData];
}

class ErrorStockState extends StockState{
  final String errorMessage;
  const ErrorStockState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
class EmptyStockState extends StockState{
  @override
  List<Object?> get props => [];
}
class SuccessFilteredStockState extends StockState{

  final List<StockData> stockData;

  const SuccessFilteredStockState({required this.stockData});
  @override
  List<Object?> get props => [stockData];
}
class EmptyStockFilteredState extends StockState{
  @override
  List<Object?> get props => [];
}