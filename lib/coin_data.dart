import 'network.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const url="https://rest.coinapi.io/v1/exchangerate";
const apiKey="03E86FAC-5BC7-4C6A-9DC4-83CB4BBADF8B";
class CoinData {

  Future<dynamic> getCurrencyRate(String currency,String coinType) async{
    Network helper=Network("$url/$coinType/$currency?apikey=$apiKey");
    var data=await helper.getExchangeRate();
    return data;
  }

}
