class StockData{
  double? open;
  double? high;
  double? low;
  double? last;
  double? close;
  double? volume;
  String? date;
  String? symbol;
  String? exchange;

  StockData(
      {this.open,
        this.high,
        this.low,
        this.last,
        this.close,
        this.volume,
        this.date,
        this.symbol,
        this.exchange});
}