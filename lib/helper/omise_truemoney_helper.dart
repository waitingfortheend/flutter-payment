import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OmiseTrueMoneyHelper {
  late final String amount;
  late final String phonenumber;

  OmiseTrueMoneyHelper({required this.amount, required this.phonenumber});

  late String token;
  late String status;
  late dynamic bodyMoney;
  Future<String> getToken() async {
    var code = latin1.fuse(base64);
    var specialKey = code.encode("pkey_test_5nz9ztce8hk2xughun3");
    try {
      var url = Uri.parse('https://api.omise.co/sources');
      http.Response response = await http.post(url, headers: {
        HttpHeaders.authorizationHeader: "Basic $specialKey"
      }, body: {
        'amount': this.amount,
        "currency": "THB",
        'phone_number': phonenumber,
        'type': "truemoney",
      });

      var respondJson = json.decode(response.body);

      if (response.statusCode != 200) {
        throw respondJson['status'];
      }
      bodyMoney = response.body;

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

  Future<dynamic> trueCharge(String description) async {
    var code = latin1.fuse(base64);
    var specialKey = code.encode("skey_test_5nz9ztcekcy011tkvtk");

    try {
      var url = Uri.parse('https://api.omise.co/charges');
      http.Response response = await http.post(url, headers: {
        HttpHeaders.authorizationHeader: "Basic $specialKey"
      }, body: {
         'amount': this.amount,
        "currency": "thb",
        'source[phone_number]': phonenumber,
        'source[type]': "truemoney",
        'source': token,
        'return_uri': "http://example.com/orders/345678/complete"

      }
      );









      var respondJson = json.decode(response.body);
      status = respondJson['status'];

      if (status != "pending") {
         throw respondJson;
      }

      // print(status);

      return respondJson;
    } catch (e) {

      throw e;
    }
  }
}
