import 'package:flutter/material.dart';
import 'package:test_flutter_diversition/screens/menu.dart';

class CheckoutDetailScreens extends StatefulWidget {
  final String productTitle;
  final String productImage;
  final double productPrice;
  final int productQty;
  final String address;
  final String order;
  CheckoutDetailScreens({
    required this.productTitle,
    required this.productImage,
    required this.productPrice,
    required this.productQty,
    required this.address,
    required this.order,
  });

  @override
  _CheckoutDetailScreensState createState() => _CheckoutDetailScreensState();
}

class _CheckoutDetailScreensState extends State<CheckoutDetailScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Finish"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.orange,
                  Colors.orangeAccent,
                  Colors.deepOrangeAccent
                ]),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                children: [
                  Text(widget.order),
                  Image.network(
                    widget.productImage,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.3,
                    alignment: Alignment.topCenter,
                  ),
                  Text('Address : ' + widget.address),
                  Text('Qty : ' + widget.productQty.toStringAsFixed(2)),
                  Text('Price : ' + widget.productPrice.toStringAsFixed(2)),
                  Positioned(
                    bottom: 10,
                    right: 15,

                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.white),
                        primary: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return WinMenu();
                        }));
                      },
                      child: const Text('Go Test Json API'),
                    ),
                    // ,FlatButton(
                    //     textColor: Colors.white,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12)),
                    //     color: Colors.redAccent,

                    //     child: Text("Buy Now")),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
