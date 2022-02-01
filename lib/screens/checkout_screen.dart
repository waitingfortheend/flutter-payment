import 'dart:math';

import 'package:flutter/material.dart';
import '../widgets/checkout_card.dart';
import '../widgets/creditcard_form.dart';
import '../helper/omise_helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../screens/checkout_detail_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final String productTitle;
  final String productImage;
  final double productPrice;
  final int productQty;
  final String address;

  CheckoutScreen({
    required this.productTitle,
    required this.productImage,
    required this.productPrice,
    required this.productQty,
    required this.address,
  });

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // ignore: unused_field
  bool _isLoading = false;

  void showDialog(
      String message, AlertType alert, String btnText, String order) {
    Alert(
        useRootNavigator: false,
        style: AlertStyle(
          isCloseButton: false,
          animationType: AnimationType.grow,
          isOverlayTapDismiss: false,
        ),
        title: "Checkout Message",
        desc: message,
        context: context,
        type: alert,
        image: Icon(Icons.perm_device_information),
        buttons: [
          DialogButton(
              color: message == 'successful'
                  ? Color.fromRGBO(0, 179, 134, 1.0)
                  : Colors.red,
              child: Text(
                btnText,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                if (message == 'successful') {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CheckoutDetailScreens(
                        productTitle: widget.productTitle,
                        productImage: widget.productImage,
                        productPrice: widget.productPrice,
                        productQty: widget.productQty,
                        address: widget.address,
                        order: order);
                  }));
                } else {
                  Navigator.of(context).pop();
                }
              }),
        ]).show();
  }

  void formSubmit(String cardHolder, String cardNumber, String cardExpiryDate,
      String cardCVC) async {
    // print([cardHolder, cardNumber, cardExpiryDate, cardCVC]);

    List<String> _expSplit = [];
    _expSplit = cardExpiryDate.split("/");

    final totalPrice =
        ((widget.productPrice * widget.productQty) * 100).toString();

    setState(() {
      _isLoading = true;
    });

    try {
      // ignore: non_constant_identifier_names
      var Charges = OmiseHelper(
          name: cardHolder,
          number: cardNumber,
          expMonth: _expSplit[0],
          expYear: _expSplit[1],
          security: cardCVC,
          price: totalPrice);

      await Charges.getToken();

      Random random = new Random();
      int randomNumber = random.nextInt(10000);
      var order = 'Order ' + randomNumber.toString();
      var respond =
          await Charges.cardCharge(order + ' address : ' + widget.address);

      var status = respond['status'];

      showDialog(status, AlertType.success, 'Ok', 'Order : ' +  order);
    } catch (e) {
      _isLoading = false;
      showDialog(e.toString(), AlertType.warning, 'Ok', '');
    }

    setState(() {
      _isLoading = false;
    });

    // print([_expSplit]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
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
                    CheckoutCard(
                        widget.productTitle,
                        widget.productImage,
                        widget.productPrice * widget.productQty,
                        true,
                        widget.productQty,
                        widget.address),
                    SizedBox(height: 10),
                    Center(
                      child: Image.asset(
                            'assets/images/iconMasterCard.png',
                            height: 150,
                            width: 300,),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Card Detail",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    CreditCartForm(
                        widget.productPrice * widget.productQty, formSubmit),
                  ],
                ),
              ),
            ),
    );
  }
}
