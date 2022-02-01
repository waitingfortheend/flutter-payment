import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class WinSalesInvoice extends StatefulWidget {
  final String token;
  final String server;
  WinSalesInvoice({required this.token, required this.server});

  @override
  _WinSalesInvoiceState createState() => _WinSalesInvoiceState();
}

class _WinSalesInvoiceState extends State<WinSalesInvoice> {
  List<Map<String, dynamic>> salesInvoice = [];

  @override
  void initState() {
    
    getSalesInvoice();
    super.initState();

  }

  bool _isLoading = false;

  getSalesInvoice() async {
    salesInvoice = [];
    setState(() {});

    // GET
    var queryParameters = {
      'ID': '3',
    };
    var uri =
        Uri.http(widget.server, '/api/SalesInvoice/GetByID', queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + widget.token,
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    if (response.statusCode == 200) {
      // ignore: unnecessary_null_comparison
      if (response.body != null) {}
    }

    // POST
    Map<String, dynamic> data = {
      "pageIndex": 0,
      "pageSize": 30,
      "searchInColumns": [],
      "moreCondition": "",
      "isPickerMode": false,
      "firstOpen": true
    };

    var dataJson = jsonEncode(data);
    print(dataJson);

    var uri2 = Uri.http(widget.server, '/api/SalesInvoice/GetList');

    http.Response response2 = await http.post(uri2,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + widget.token,
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: dataJson);

    if (response2.statusCode == 200) {
      // ignore: unnecessary_null_comparison
      if (response2.body != null) {
        // ignore: unnecessary_null_comparison
        if (response2.body != null) {
          final Map parsed = json.decode(response2.body);

          // var _list = parsed.values.toList();

          // for (dynamic v in json.decode(response2.body)) {
          //   salesInvoice.add(v);
          // }
          // print(parsed);

          // var aa = _list[0];
          var datas = parsed['Data'];
          var newData = datas[0];
          print(datas);
          for (var i = 0; i < newData.length; i++) {
            salesInvoice.add(newData[i]);
          }
          // for (dynamic data in aa) {
          //   salesInvoice.add(aa[]);

          // }
          setState(() {});
        }
      }
    }
  }

  Widget genSalesInvoice(dynamic row) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 100.0,
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width - 200.0,
                child: Text(
                  row['CustomerName'] + ' ' + row['DocuNo'],
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: row['DocuFlag'] == 2100 ? Colors.red : Colors.black,
                  ),
                ),
              ),
              // Container(
              //   width: 100.0,
              //   child: Text(
              //     DateFormat('dd/MM/yyyy')
              //         .format(DateTime.parse(row['ModifiedDate'])),
              //     textAlign: TextAlign.right,
              //     style: TextStyle(
              //       fontSize: 14.0,
              //       color: row['DocuFlag'] == 2100 ? Colors.red : Colors.black,
              //     ),
              //   ),
              // ),
            ],
          ),
          row['SearchName'] != ''
              ? Container(
                  width: (width - 100.0),
                  child: Text(
                    'SearchName: ' + row['SearchName'],
                    style: TextStyle(
                      fontSize: 16.0,
                      color:
                          row['DocuFlag'] == 2100 ? Colors.red : Colors.black,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: salesInvoice.map((e) => genSalesInvoice(e)).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Test Json Api Server'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              tooltip: 'SalesInvoice',
              onPressed: () {
                Navigator.pop(context, false);
                Navigator.pop(context, false);
                Navigator.pop(context, false);
              },
            ),
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(child: body()),
      ),
    );
  }
}
