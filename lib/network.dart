import 'dart:convert';
import 'package:http/http.dart';

class Network{
  Network(this.url);
  final String url;

  Future getExchangeRate() async{
    Response response= await get(url);
    if(response!=null){
      String data=response.body;
      var decodedData=jsonDecode(data);
      return decodedData;
    }else{
      print(response.statusCode);
    }
  }

}