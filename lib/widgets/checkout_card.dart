import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckoutCard extends StatefulWidget {
  final String title;
  final String image;
  final double price;
  final bool isCheckout;
  final int qty;
  final String address;
  CheckoutCard(this.title, this.image, this.price, this.isCheckout, this.qty,
      this.address);

  final currency = NumberFormat("#,##0", "en_US");

  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.image,
                  width: 70,
                  height: 70,
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        widget.isCheckout
                            ? Text(
                                "Quantity : " + widget.qty.toStringAsFixed(2),
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              )
                            : new Container(),
                        widget.isCheckout
                            ? Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Row(
                                  children: [Text(    "Address : " +  widget.address , style: TextStyle(fontSize: 15),) ,],
                                ),
                            )
                            : new Container(),
                      ],
                    )),
              ],
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
