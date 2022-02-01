import 'package:flutter/material.dart';
import './screens/product_screen.dart';

void main() {
  runApp(ProductApp());
}

class ProductApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductScreen(),

    );
  }


}
