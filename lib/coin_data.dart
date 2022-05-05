import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
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

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const coinAPIURL = "http://rest.coinapi.io/v1/exchangerate";
const apiKey = "CCE592FE-73D6-4081-9943-0C14C883A9C3";

class CoinData {
  Future getCoinData(String selectedCurrency) async{
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String requestURL = "$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey";
      http.Response response = await http.get(Uri.parse(requestURL));

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw "Problem with the GET Request";
      }
    }
    return cryptoPrices;
  }
}
