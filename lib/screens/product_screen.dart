import 'package:flutter/material.dart';
import '../model/product.dart';
import '../widgets/product_list.dart';
import 'package:intl/intl.dart';
import '../screens/address_screen.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  static List<Products> bestProduct = [
    Products(
        id: 1,
        title:
            "Hammer Anvil Bryce Men Wool Blend Double Breasted Jacket Pea Coat",
        price: 1417.00,
        image: 'https://i.ebayimg.com/images/g/C1UAAOSwf~Ndx~BZ/s-l1600.jpg'),
    Products(
        id: 2,
        title:
            "Men Japanese Shirt Tops Pocket Short Sleeve Denim Cotton Slim Casual Wear",
        price: 1000.00,
        image: "https://i.ebayimg.com/images/g/MsoAAOSwiuVexU9m/s-l1600.jpg"),
    Products(
        id: 3,
        title:
            "Women's Short Sleeve T shirt Summer Fashion Slim Party Floral Skirt 2pc dress",
        price: 1280.00,
        image: "https://i.ebayimg.com/images/g/6uoAAOSw-1te1183/s-l1600.jpg"),
    Products(
        id: 4,
        title:
            "Women's Short Sleeve Tops Summer Sexy Party Slim Party New Skirt 2pc",
        price: 960.00,
        image: "https://i.ebayimg.com/images/g/weUAAOSwEDde12P1/s-l1600.jpg"),
  ];

  String showImage = bestProduct[0].image;
  String showTitle = bestProduct[0].title;
  double showPrice = bestProduct[0].price;

  final currency = NumberFormat("#,##0", "en_US");

  void showProduct(
      String productImage, String productTitle, double productPrice) {
    // print([productImage,productTitle,productPrice]);

    setState(() {
      showImage = productImage;
      showTitle = productTitle;
      showPrice = productPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
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
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: double.infinity,
                      child: Image.network(
                        showImage,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.6,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black87, Colors.transparent])),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              showTitle,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "฿ ${currency.format(showPrice)}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.greenAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
      
                  // Positioned(
                  //     bottom: 55,
                  //     right: 15,
                  //     child: Container(
                  //       child: Row(
                  //         children: [
                  //           _dataQty != 1
                  //               ? new IconButton(
                  //                   icon: new Icon(Icons.remove),
                  //                   onPressed: () => setState(() => _dataQty--),
                  //                 )
                  //               : new Container(),
                  //           new Text(_dataQty.toString()),
                  //           new IconButton(
                  //               icon: new Icon(Icons.add),
                  //               onPressed: () => setState(() => _dataQty++))
                  //         ],
                  //       ),
                  //     )
      
                      // DropdownButton<int>(
                      //     value: dataQty,
                      //     icon: const Icon(Icons.arrow_downward),
                      //     iconSize: 20,
                      //     elevation: 20,
      
                      //     style: const TextStyle(color: Colors.deepPurple),
                      //     underline: Container(
                      //       height: 2,
                      //       color: Colors.deepPurpleAccent,
                      //     ),
                      //     onChanged: (int? newValue) {
                      //       setState(() {
                      //         dataQty = newValue!;
                      //       });
                      //     },
                      //     items: <int>[1, 2, 3, 4,5]
                      //         .map<DropdownMenuItem<int>>((int value) {
                      //       return DropdownMenuItem<int>(
                      //         value: value,
                      //         child: Text(value.toString()),
                      //       );
                      //     }).toList(),
      
                      // )
                      // ,FlatButton(
                      //     textColor: Colors.white,
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12)),
                      //     color: Colors.redAccent,
                      //     child: Text("Buy Now")),
                      // ),
                  // ignore: deprecated_member_use
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
                          return 
                          AddressScreen(
                            productImage: showImage,
                            productTitle: showTitle,
                            productPrice: showPrice,
                          );
                          
                         
                        }));
                      },
                      child: const Text('Buy Now'),
                    ),
                    // ,FlatButton(
                    //     textColor: Colors.white,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12)),
                    //     color: Colors.redAccent,
      
                    //     child: Text("Buy Now")),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Text(
                      "Best Selling",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ProductList(bestProduct, showProduct)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
