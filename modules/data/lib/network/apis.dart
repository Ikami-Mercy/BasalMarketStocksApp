class Apis {
  static const FETCH_MARKET_STOCK_TICKERS = '/tickers?access_key={access_key}&limit={limit}';
  static const FETCH_MARKET_STOCK_INTRADAY = '/eod?access_key={access_key}&limit={limit}&symbols={symbols}';
}