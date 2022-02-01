import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CheckoutTrueForm extends StatefulWidget {
  final double price;
  final Function formSubmit;

  CheckoutTrueForm(this.price, this.formSubmit);

  @override
  _CheckoutTrueFormState createState() => _CheckoutTrueFormState();
}

class _CheckoutTrueFormState extends State<CheckoutTrueForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var cardHolderFormatter =
      FilteringTextInputFormatter.allow(RegExp("[A-Za-z 0-9]"));

  var cardNumberFormatter = MaskTextInputFormatter(
      mask: "##-###-##-##", filter: {"#": RegExp(r'[0-9]')});

  final currency = NumberFormat("#,##0", "en_US");

  void submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();

    widget.formSubmit(cardNumberFormatter.getUnmaskedText(), widget.price);

    // print([
    //   _cardHolder,
    //   cardNumberFormatter.getMaskedText(),
    //   expiryDateFormatter.getMaskedText(),
    //   cvcFormatter.getMaskedText()
    // ]);
  }

  showAlertDialog() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Widget cancelButton = DialogButton(
      color: Colors.black87,
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => Navigator.pop(context, false),
    );
    Widget continueButton = DialogButton(
        color: Colors.redAccent,
        child:
            Text("Confirm to Payment", style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.pop(context, false);
          submit();
        });

    AlertDialog alert = AlertDialog(
      title: Text("Confirm Payment"),
      content: Text("Payment"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget cardForm(
      {required String label,
      bool obscure = false,
      TextInputType inputType = TextInputType.text,
      required Function saveValue,
      required Function validation,
      required TextInputFormatter formatter}) {
    return TextFormField(
      inputFormatters: [formatter],
      keyboardType: inputType,
      obscureText: obscure,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black26),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black26),
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 15,
          color: Colors.black45,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextStyle(
        fontSize: 15,
        color: Colors.black54,
        fontWeight: FontWeight.bold,
      ),
      onSaved: saveValue(),
      validator: validation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  cardForm(
                      label: "PhoneNumber",
                      inputType: TextInputType.number,
                      saveValue: () => (value) {},
                      validation: () => (value) {
                            if (value.isEmpty || value.length < 12) {
                              return "Invalid phonenumber";
                            } else {
                              return null;
                            }
                          },
                      formatter: cardNumberFormatter),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 52,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  color: Colors.black26,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Secure Payment",
                  style: TextStyle(color: Colors.black26),
                )
              ],
            ),
          ),
          Container(
              width: double.infinity,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.redAccent),
                onPressed: showAlertDialog,
                child: Text(
                  "Pay ฿ ${widget.price} THB",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              )
              // , RaisedButton(
              //   padding: EdgeInsets.all(13),
              //   color: Colors.redAccent,
              //   onPressed: submit,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10)),
              //   child: Text(
              //     "Pay ฿ ${currency.format(widget.price)} THB",
              //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              //   ),
              // ),
              )
        ],
      ),
    );
  }
}
