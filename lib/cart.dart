import 'package:flutter/material.dart';
import 'package:ordering/models/cartModel.dart';
import 'package:ordering/services/cartService.dart';
import 'package:ordering/total.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cart extends StatefulWidget {
  final CartModel cartModel;
  Cart({this.cartModel});
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartModel> cartList;
  bool loading = true;

  getAllCart() async {
    cartList = await CartService().getCart();
    setState(() {
      loading = false;
    });
    print("cart : ${cartList.length}");
  }

  deleteToCart(CartModel cartModel) async {
    try {
      await CartService().deleteCart(cartModel);
      setState(() {
        loading = false;
        getAllCart();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Basket'),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisSize: MainAxisSize.max,
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
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Center(
                          child: Text(
                            'San Marino Residence, Cebu city',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        CartModel cart = cartList[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: ListTile(
                              title: Text(
                                cart.menuname,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                cart.menuprice,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              onLongPress: () {
                                showDeleteToCart(cart);
                              },
                            ),
                          ),
                        );
                      }),
                ),
                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                //     child: Column(
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               'Total ',
                //               style: TextStyle(
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //             Text(
                //               '1,370',
                //               style: TextStyle(
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
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
    );
  }
}
