import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddressForm extends StatefulWidget {
  final String address;
  final Function addressSubmit;

  AddressForm(this.address, this.addressSubmit);

  @override
  _AddressFormState createState() => _AddressFormState();
}

enum SingingCharacter { masterCard, other }

class _AddressFormState extends State<AddressForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var postCode =
      MaskTextInputFormatter(mask: "###", filter: {"#": RegExp(r'[0-9]')});

  var addressFormatter =
      FilteringTextInputFormatter.allow(RegExp("[A-Za-z 0-9]"));

  late String _address;

  SingingCharacter? _choicePayment = SingingCharacter.masterCard;

  void addressSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();

    widget.addressSubmit(_address,_choicePayment!.index);
  }

  Widget addressForm(
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
          fontSize: 20,
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
                  addressForm(
                      label: "Address",
                      inputType: TextInputType.text,
                      saveValue: () => (value) {
                            _address = value;
                          },
                      validation: () => (value) {
                            if (value.isEmpty) {
                              return "Invalid Address";
                            } else {
                              return null;
                            }
                          },
                      formatter: addressFormatter),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Payments with',style: TextStyle(fontSize: 20 ,color: Colors.deepOrange,fontWeight: FontWeight.bold),)),
                  ),
                  Column(
                    children: [
                      ListTile(
                        title: 
                        // Image.asset('assets/images/iconMasterCard.png',scale: 10,),
                        Text('MasterCard Debit/Credit'
                         ),
                        
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.masterCard,
                          groupValue: _choicePayment,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _choicePayment = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Truemoney'),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.other,
                          groupValue: _choicePayment,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _choicePayment = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
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
                  Icons.post_add,
                  color: Colors.black26,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Address",
                  style: TextStyle(color: Colors.black26),
                )
              ],
            ),
          ),
          Container(
              width: double.infinity,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.orange),
                onPressed: addressSubmit,
                child: Text('Confirm Next  Payment'),
              )),
        ],
      ),
    );
  }
}
