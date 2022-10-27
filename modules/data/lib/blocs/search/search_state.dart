import 'package:dependencies/dependencies.dart';
import 'package:domain/models/stock_data.dart';

abstract class SearchState extends Equatable{
  const SearchState();
}

class InitialSearchState extends SearchState{
  @override
  List<Object?> get props => [];

}

class LoadingSearchState extends SearchState{
  @override
  List<Object?> get props => [];
}

class SuccessSearchState extends SearchState{

  final List<StockData> stockData;

  const SuccessSearchState({required this.stockData});
  @override
  List<Object?> get props => [stockData];
}

class ErrorSearchState extends SearchState{
  @override
  List<Object?> get props => [];
}
class EmptySearchState extends SearchState{
  @override
  List<Object?> get props => [];
}