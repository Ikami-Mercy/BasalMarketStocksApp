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
  @override
  List<Object?> get props => [];
}