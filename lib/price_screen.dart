import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";
  double exchangeRateBTC=0.0;
  double exchangeRateETH=0.0;
  double exchangeRateLTC=0.0;
  void updateUi(dynamic coinDataBTC,dynamic coinDataETH,dynamic coinDataLTC){
    setState(() {
      if(coinDataBTC == null || coinDataETH == null || coinDataLTC == null){
        exchangeRateBTC = 0.0;
        exchangeRateETH = 0.0;
        exchangeRateLTC = 0.0;
      }else {
        exchangeRateBTC = coinDataBTC['rate'];
        exchangeRateETH = coinDataETH['rate'];
        exchangeRateLTC = coinDataLTC['rate'];
      }
    });
  }

  CupertinoPicker getIosPicker(){
    List<Widget> list=[];
    for(String cur in currenciesList){
      list.add(
          Text(cur)
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (int value) {
        print(value);
      },
      children: list,
      itemExtent: 32.0,
    );
  }
  DropdownButton<String> getAndroidDropdown(){
    List<DropdownMenuItem<String>> list = [];
    for (int i = 0; i <= currenciesList.length - 1; i++) {
      list.add(DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      ));
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: list,
      onChanged: (value) async{
          selectedCurrency = value;
          var dataBTC = await CoinData().getCurrencyRate(selectedCurrency, "BTC");
          var dataETH = await CoinData().getCurrencyRate(selectedCurrency, "ETH");
          var dataLTC = await CoinData().getCurrencyRate(selectedCurrency, "LTC");
          updateUi(dataBTC,dataETH,dataLTC);

      },
    );
  }

  Widget getPicker(){
    if(Platform.isIOS){
      return getIosPicker();
    }
    if(Platform.isAndroid){
      return getAndroidDropdown();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $exchangeRateBTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $exchangeRateETH $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $exchangeRateLTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}

