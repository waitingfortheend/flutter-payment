import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OmiseHelper {
  late final String name;
  late final String number;
  late final String expMonth;
  late final String expYear;
  late final String security;
  late final String price;

  OmiseHelper(
      {required this.name,
      required this.number,
      required this.expMonth,
      required this.expYear,
      required this.security,
      required this.price
      });

  late String token;
  late String status;

  Future<String> getToken() async {
    var code = latin1.fuse(base64);
    var specialKey = code.encode("pkey_test_5nz9ztce8hk2xughun3");
    try {
      var url = Uri.parse('https://vault.omise.co/tokens');
      http.Response response =
          await http.post(url, headers: {
        HttpHeaders.authorizationHeader: "Basic $specialKey"
      }, body: {
        'card[name]': this.name,
        'card[number]': this.number,
        'card[expiration_month]': this.expMonth,
        'card[expiration_year]': this.expYear,
        'card[security_code]': this.security,
      });


      var respondJson = json.decode(response.body);
 
      if(response.statusCode != 200) {
         throw respondJson['message'];
      }
      
      // if(status != "successful") {
      //   throw respondJson['message'];
      // }

       token = respondJson['id'];
      // // ignore: unnecessary_null_comparison
      // if(token == null) {
      //   throw respondJson['message'];
      // } 


      return token;

      // print(respondJson);

    } catch (e) {

      throw e;

    }



  }

  
    Future<dynamic> cardCharge(String description) async {
    var code = latin1.fuse(base64);
    var specialKey = code.encode("skey_test_5nz9ztcekcy011tkvtk");

    try {

      var url = Uri.parse('https://api.omise.co/charges');
      http.Response response =
          await http.post(url, headers: {
        HttpHeaders.authorizationHeader: "Basic $specialKey"
      }, body: {
        'amount' : price,
        'card' : token,
        'description': description,
        'currency': 'thb'
      }
      
      );

     var respondJson = json.decode(response.body);
      status = respondJson['status'];
  
      if(status != "successful") {
        throw respondJson['message'];
      }

      
      // print(status);

      return respondJson;

    } catch (e) {
      throw e;
    }


    }

}
