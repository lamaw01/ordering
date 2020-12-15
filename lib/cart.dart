import 'package:flutter/material.dart';
import 'file:///C:/Users/janre/Documents/Flutter%20Projects/ordering/color/colors.dart';
import 'package:ordering/models/cartModel.dart';
import 'package:ordering/models/totalModel.dart';
import 'package:ordering/services/cartService.dart';
import 'package:ordering/services/totalValService.dart';
import 'package:ordering/total.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartModel> cartList;
  List<TotalValModel> totalValList;
  bool loading = true;

  getAllCart() async {
    cartList = await CartService().getCart();
    setState(() {
      loading = false;
    });
    print("cart : ${cartList.length}");
  }

  getTotalVal() async {
    totalValList = await TotalValService().getMenu();
    setState(() {
      loading = false;
    });
    print("total : ${totalValList.length}");
  }

  deleteToCart(CartModel cartModel) async {
    try {
      await CartService().deleteCart(cartModel);
      setState(() {
        loading = false;
        getAllCart();
        getTotalVal();
      });
      Toast.show(
        "Item Removed",
        context,
        gravity: Toast.CENTER,
        duration: 2,
      );
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
      print('yawa');
    }
  }

  showDeleteToCart(cartIdParam) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Remove this item from basket?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes.'),
              onPressed: () {
                print(cartIdParam);
                deleteToCart(cartIdParam);
              },
            ),
            TextButton(
              child: Text('Cancel.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future totalSum() async {
    try {
      var url = "http://192.168.0.12/ordering/total.php";
      var response = await http.post(url);
      var data = json.decode(response.body);
      print(data);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getAllCart();
    getTotalVal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerColor,
        centerTitle: true,
        title: Text(
          'Your Basket',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              Text(
                                'Deliver to',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              'San Marino Residence, Cebu city',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context, index) {
                          CartModel cart = cartList[index];
                          if (cartList.isNotEmpty) {
                            return GestureDetector(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            cart.menuname,
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          Text(
                                            cart.menuprice,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                showDeleteToCart(cart);
                              },
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: totalValList.length,
                        itemBuilder: (context, index) {
                          TotalValModel cart = totalValList[index];
                          if (totalValList.isNotEmpty) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        Text(
                                          cart.total,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cash',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Icon(
                                Icons.money,
                                color: Colors.grey[700],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Icon(
                                Icons.pages,
                                color: Colors.grey[700],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Icon(
                                Icons.credit_card,
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cash',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Promo Code',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'PrayMaya',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.check_box_outlined,
                                color: Colors.red,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Enter Promo Code',
                                style: TextStyle(
                                  fontSize: 10,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Connect Account',
                                style: TextStyle(
                                  fontSize: 10,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Total(),
                        ),
                      );
                    },
                    child: Text(
                      'PLACE ORDER',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
