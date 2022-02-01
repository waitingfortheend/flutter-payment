import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../widgets/address_form.dart';
import '../widgets/checkout_card.dart';
import '../screens/checkout_screen.dart';
import '../screens/checkout_true_screen.dart';

class AddressScreen extends StatefulWidget {
  final String productTitle;
  final String productImage;
  final double productPrice;

  AddressScreen(
      {required this.productTitle,
      required this.productImage,
      required this.productPrice});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  // ignore: unused_field
  bool _isLoading = false;
  late String dataAddress = '';
  late bool isCheckout = true;

  final currency = NumberFormat("#,##0", "en_US");

  int _dataQty = 1;
  void addressSubmit(String address, int choicePayment) {
    showAlertDialog(this._dataQty, choicePayment, address);

    // print(choicePayment);
    // Alert(
    //     useRootNavigator: false,
    //     style: AlertStyle(
    //       isCloseButton: true,
    //       animationType: AnimationType.grow,
    //       isOverlayTapDismiss: true,
    //     ),
    //     title: "Confirm to Payment",
    //     desc: address,
    //     context: context,
    //     type: AlertType.info,
    //     image: Icon(Icons.perm_device_information),
    //     buttons: [
    //       DialogButton(
    //           color: Colors.blueAccent,
    //           child: Text(
    //             "Payment",
    //             style: TextStyle(color: Colors.white, fontSize: 20),
    //           ),
    //           onPressed: () => (value) {

    //                 print(value);
    //               }),
    //     ]).show();
  }

  showAlertDialog(int productQty, int choicePayment, String address) {
    // set up the buttons
    Widget cancelButton = DialogButton(
      color: Colors.black87,
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => Navigator.pop(context, false),
    );
    Widget continueButton = DialogButton(
        color: Colors.orangeAccent,
        child:
            Text("Continue to Payment", style: TextStyle(color: Colors.white)),
        onPressed: () {
          if (choicePayment == 0) {
            Navigator.pop(context, false);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return CheckoutScreen(
                  productTitle: widget.productTitle,
                  productImage: widget.productImage,
                  productPrice: widget.productPrice,
                  productQty: productQty,
                  address: address);
            }));
          } else {
            Navigator.pop(context, false);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              var amounts = widget.productPrice * _dataQty;
              return CheckoutTrueScreen(
                  amount: amounts,
                  productTitle: widget.productTitle,
                  productImage: widget.productImage,
                  productPrice: widget.productPrice,
                  productQty: productQty,
                  address: address);
            }));
          }
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm to Continue"),
      content: Text("Go to Payment"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckoutCard(widget.productTitle, widget.productImage,
                        widget.productPrice, false, 0, ''),
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Quantity : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.redAccent),
                            ),
                          ),
                          this.isCheckout
                              ? Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: new IconButton(
                                    icon: new Icon(Icons.remove),
                                    onPressed: () => setState(() =>
                                        _dataQty != 1
                                            ? _dataQty--
                                            : _dataQty = 1),
                                  )
                                  // : new Container(),
                                  )
                              : new Container(),
                          new Text(_dataQty.toString()),
                          this.isCheckout
                              ? new IconButton(
                                  icon: new Icon(Icons.add),
                                  onPressed: () => setState(() => _dataQty++),
                                )
                              : new Container(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Total ฿ ${this.currency.format(widget.productPrice * _dataQty)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.only(left: 25),
                      child: Text(
                        "Shipping",
                        style:
                            TextStyle(fontSize: 16, color: Colors.blueAccent),
                      ),
                    ),
                    AddressForm(dataAddress, addressSubmit),
                  ],
                ),
              ),
            ),
    );
  }
}
