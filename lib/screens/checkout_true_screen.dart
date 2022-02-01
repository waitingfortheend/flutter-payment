import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:test_flutter_diversition/helper/omise_truemoney_helper.dart';
import '../widgets/checkout_true_form.dart';
import '../widgets/checkout_card.dart';
import '../screens/checkout_detail_screen.dart';

class CheckoutTrueScreen extends StatefulWidget {
  final double amount;
  final String productTitle;
  final String productImage;
  final double productPrice;
  final int productQty;
  final String address;

  CheckoutTrueScreen({
    required this.amount,
    required this.productTitle,
    required this.productImage,
    required this.productPrice,
    required this.productQty,
    required this.address,
  });

  @override
  _CheckoutTrueScreenState createState() => _CheckoutTrueScreenState();
}

class _CheckoutTrueScreenState extends State<CheckoutTrueScreen> {
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
              color: message == 'pending'
                  ? Color.fromRGBO(0, 179, 134, 1.0)
                  : Colors.red,
              child: Text(
                btnText,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                if (message == 'pending') {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CheckoutDetailScreens(
                        productTitle: widget.productTitle,
                        productImage: widget.productImage,
                        productPrice: widget.productPrice * widget.productQty,
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

  void formSubmit(String phonenumber, double prices) async {
    setState(() {
      _isLoading = true;
    });


    final totalPrice = ((prices * widget.productQty) * 100).toInt();
 

    try {
      var chargeTrue = OmiseTrueMoneyHelper(
          amount: totalPrice.toString(), phonenumber: phonenumber);
      await chargeTrue.getToken();
      var respond = await chargeTrue.trueCharge(phonenumber);
      var status = respond["status"];
      showDialog(
          status, AlertType.success, 'Ok', 'Phone Number ' + phonenumber);
    } catch (e) {
      _isLoading = false;
      showDialog(e.toString(), AlertType.warning, 'Ok', '');
    }
    setState(() {
      _isLoading = false;
    });



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Truemoney Payment"),
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
                        widget.productPrice,
                        true,
                        widget.productQty,
                        widget.address),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Image.asset(
                          'assets/images/true-money.png',
                          height: 100,
                          width: 300,
                        ),
                      ),
                    ),
                    CheckoutTrueForm(widget.amount, formSubmit),
                  ],
                ),
              ),
            ),
    );
  }
}
