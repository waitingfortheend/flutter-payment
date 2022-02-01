import 'package:flutter/material.dart';
import '../module/CS/saleinvoice.dart';

class WinMenu extends StatefulWidget {
  @override
  _WinMenuState createState() => _WinMenuState();
}

class _WinMenuState extends State<WinMenu> {
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiIyNSIsInVubSI6Im8iLCJwd2QiOiJSRUFrcVM3WXpQZz0iLCJkYnBmIjoiRGV2ZWxvcGVyIGFuZCBUZXN0ZXIiLCJpc3JtYiI6InRydWUiLCJsZ2lkIjoiMzMiLCJjbHRyY2QiOiJ0aC1USCIsImxnbm0iOiLguYTguJfguKItVGhhaSIsInN5ZHQiOiJcIjIwMjEtMDUtMjRUMTY6MjE6MzYuNTM3MjQ4MiswNzowMFwiIiwiZW1pZCI6IjM0IiwiZW1jZCI6IkNNNjAtNDEyIiwiZW1ubSI6IlRhbmFwb25nIFRoYWltYWkiLCJlbXBmeCI6IiIsImVtbCI6IiIsImRwaWQiOiIwIiwiZHBjZCI6IiIsImRwbm0iOiIiLCJyc3BpZCI6IjEiLCJyc3BjZCI6IiIsInJzcG5tIjoiQWRtaW5pc3RyYXRvciIsImlzYWJ5ciI6ImZhbHNlIiwiaXNhaW52IjoiZmFsc2UiLCJpc2FzcCI6ImZhbHNlIiwiaXNhY20iOiJ0cnVlIiwib3JpZCI6IjEiLCJvcmNkIjoiUFMgMDAxIiwib3JjcnJubSI6IuC4muC4o-C4tOC4qeC4seC4lyDguYLguJvguKPguIvguK3guJ_guJfguYwg4LiE4Lit4Lih4LmA4LiX4LiEIOC4iOC4s-C4geC4seC4lCIsIm9ybm0iOiLguJrguKPguLTguKnguLHguJcg4LmC4Lib4Lij4LiL4Lit4Lif4LiX4LmMIOC4hOC4reC4oeC5gOC4l-C4hCDguIjguLPguIHguLHguJQiLCJvcnBmeCI6IiIsImJyY2lkIjoiMiIsImJyY2NkIjoiQktLIiwiYnJjbm0iOiLguKrguLPguJnguLHguIHguIfguLLguJnguYPguKvguI3guYgiLCJuYmYiOjE2MjE4NDgwOTcsImV4cCI6MTYyMTg0ODE1NywiaWF0IjoxNjIxODQ4MDk3LCJpc3MiOiJQcm9zb2Z0LldpbnNwZWVkQ2xvdWQuQVBJIiwiYXVkIjoiUHJvc29mdC5XaW5zcGVlZENsb3VkLkNsaWVudCJ9.To859tv6XXtkWoBuoOlidw0nZRA1owPoREUYT5tqsMI';
  String server = 'prosoft.gotdns.com:14085';

  dynamic menu = [
    {
      'menuCode': 'salesinvoice',
      'menuName': 'Sales invoice',
      'icon': Icons.queue_play_next_sharp,
    },
  ];

  navigatePage(row) {
    switch (row['menuCode']) {
      case 'salesinvoice':
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                WinSalesInvoice(token: token, server: server)));
        break;


      default:
    }
  }

  Widget genMenu(row) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => navigatePage(row),
      child: Container(
        width: width,
        height: 100.0,
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: [
            Container(
              width: 100.0,
              child: Icon(
                row['icon'],
                size: 50.0,
              ),
            ),
            Container(
              width: width - 120.0,
              child: Text(
                row['menuName'],
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: menu.map<Widget>((e) => genMenu(e)).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }
}
