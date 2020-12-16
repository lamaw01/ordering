import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ordering/checkout.dart';
import 'package:ordering/colors.dart';
import 'package:ordering/models/cartModel.dart';
import 'package:ordering/models/checkoutModel.dart';
import 'package:ordering/models/totalModel.dart';
import 'package:ordering/services/cartService.dart';
import 'package:ordering/services/checkoutService.dart';
import 'package:ordering/services/totalValService.dart';
import 'package:toast/toast.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartModel> cartList;
  List<TotalValModel> totalValList;
  List<CheckoutModel> checkoutList;
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
        duration: 1,
      );
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
      print('yawa');
    }
  }

  showDeleteToCart(cartIdParam, cartMenuNameParam) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Remove',
            style: TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Remove $cartMenuNameParam from basket?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Yes.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              onPressed: () {
                // print(cartIdParam);
                deleteToCart(cartIdParam);
              },
            ),
            TextButton(
              child: Text(
                'Cancel.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  addToCheckout(CheckoutModel checkoutModel) async {
    try {
      await CheckoutService().addCheckout(checkoutModel).then((success) async {
        Toast.show(
          "Ordered",
          context,
          gravity: Toast.CENTER,
          duration: 2,
        );
        try {
          await http.delete('http://192.168.0.12/ordering/delete_all_cart.php');
        } catch (e) {
          print(e);
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Checkout(),
          ),
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }

  showCheckout(totalParam) async {
    CheckoutModel checkoutModel = CheckoutModel(
      summary: totalParam,
    );
    return showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Checkout?',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: titleColor,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'You will pay a total of ₱ $totalParam',
                  style: TextStyle(
                    // fontSize: 12,
                    // fontFamily: 'Poppins',
                    color: titleColor,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: Text(
                  'Yes.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  addToCheckout(checkoutModel);
                }),
            TextButton(
              child: Text(
                'Cancel.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
        iconTheme: IconThemeData(
          color: titleColor,
        ),
        backgroundColor: canvasColor,
        centerTitle: true,
        title: Text(
          'Your Basket',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: titleColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              getAllCart();
              getTotalVal();
            },
          ),
        ],
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
                            return Card(
                              child: Theme(
                                data: ThemeData(
                                  // highlightColor: buttonColor,
                                  splashColor: buttonColor,
                                ),
                                child: ListTile(
                                  leading: Text(
                                    cart.menuname,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  trailing: Text(
                                    cart.menuprice,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onTap: () {
                                    showDeleteToCart(cart, cart.menuname);
                                  },
                                ),
                              ),
                            );
                            // return GestureDetector(
                            //   child: Theme(
                            //     data: ThemeData(
                            //       splashColor: buttonColor,
                            //     ),
                            //     child: Card(
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Column(
                            //           children: [
                            //             Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceBetween,
                            //               children: [
                            //                 Text(
                            //                   cart.menuname,
                            //                   style: TextStyle(
                            //                     color: Colors.grey[700],
                            //                     fontSize: 12,
                            //                     fontFamily: 'Poppins',
                            //                   ),
                            //                 ),
                            //                 Text(
                            //                   cart.menuprice,
                            //                   style: TextStyle(
                            //                     fontSize: 14,
                            //                     fontWeight: FontWeight.bold,
                            //                     fontFamily: 'Poppins',
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            //   onTap: () {
                            //     showDeleteToCart(cart);
                            //   },
                            // );

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
                          if (cart.total != null) {
                            return Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                            return Container();
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
                                'Payment',
                                style: TextStyle(
                                  fontSize: 14,
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
                              Text(''),
                              SizedBox(
                                height: 6,
                              ),
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
                                'PayMaya',
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
                              Text(''),
                              SizedBox(
                                height: 6,
                              ),
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
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[500],
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Connect Account',
                                style: TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: totalValList.length,
                        itemBuilder: (context, index) {
                          TotalValModel sumKey = totalValList[index];
                          if (sumKey.total == null) {
                            return RaisedButton(
                              onPressed: () {},
                              child: Text(
                                'EMPTY ORDER',
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
                            );
                          } else {
                            return RaisedButton(
                              onPressed: () {
                                showCheckout(sumKey.total);
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
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
