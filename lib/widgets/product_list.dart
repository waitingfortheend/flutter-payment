import 'package:flutter/material.dart';
import '../model/product.dart';
import 'package:intl/intl.dart';

class ProductList extends StatelessWidget {
  final List<Products> product;

  final Function showProduct;

  ProductList(this.product,this.showProduct);

  final currency = NumberFormat("#,##0","en_US");


  @override
  Widget build(BuildContext context) {
    
    return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: product.length,
            itemBuilder: (context, i) {
              return Container(
                width: 130,
                child: GestureDetector(
                  onTap: () {

                    this.showProduct(product[i].image,product[i].title,product[i].price);

                  },
                  child: Card(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              child: Image.network(
                                product[i].image,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ))),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: product[i].title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text("฿ ${currency.format(product[i].price)}",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.redAccent),),
                        ]),
                      ),
                    ],
                  )),
                ),
              );
            }));
  }
}
