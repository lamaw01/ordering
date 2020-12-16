import 'package:flutter/material.dart';
import 'package:ordering/cart.dart';
import 'colors.dart';
import 'package:ordering/models/menuModel.dart';
import 'package:ordering/services/menuService.dart';
import 'package:ordering/models/cartModel.dart';
import 'package:ordering/services/cartService.dart';
import 'package:toast/toast.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

class Menu extends StatefulWidget {
  final CartModel cartModel;
  Menu({this.cartModel});
  // Menu() : super();
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<MenuModel> menuList;
  // List<CartModel> cartList;
  bool loading = true;

  getAllMenu() async {
    menuList = await MenuService().getMenu();
    setState(() {
      loading = false;
    });
    print("menu : ${menuList.length}");
  }

  addToCart(CartModel cartModel) async {
    try {
      await CartService().addCart(cartModel).then((success) {
        Toast.show(
          "Item added",
          context,
          gravity: Toast.CENTER,
          duration: 1,
        );
        Navigator.pop(context);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  showAddToCart(menuidPara, menunamePara, menupricePara) async {
    CartModel cartModel = CartModel(
      menuid: menuidPara,
      menuname: menunamePara,
      menuprice: menupricePara,
    );
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Purchase',
            style: TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Add $menunamePara to basket?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
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
                  // print(cartModel.menuid + "asf");
                  addToCart(cartModel);
                }

                // Navigator.of(context).pop();
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

  @override
  void initState() {
    super.initState();
    getAllMenu();
  }

  var imageUrl = 'http://192.168.0.12/ordering/img/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: titleColor,
        ),
        backgroundColor: canvasColor,
        title: Text(
          'Menu List',
          style: TextStyle(
            color: titleColor,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: canvasColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: menuList.length,
                    itemBuilder: (context, index) {
                      MenuModel menu = menuList[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                          child: Theme(
                            data: ThemeData(
                              // highlightColor: buttonColor,
                              splashColor: buttonColor,
                            ),
                            child: ListTile(
                              leading: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 70,
                                  minHeight: 70,
                                  maxWidth: 70,
                                  maxHeight: 70,
                                ),
                                child: Image.network(
                                  imageUrl + menu.menuimg,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // leading: Container(
                              //   width: 80,
                              //   height: 80,
                              //   child: Image.network(imageUrl + menu.menuimg),
                              // ),
                              title: Text(
                                menu.menuname,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                menu.menudescription,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              trailing: Text(
                                menu.menuprice,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              onTap: () {
                                showAddToCart(
                                  menu.menuid,
                                  menu.menuname,
                                  menu.menuprice,
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cart(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.shopping_basket),
            ],
          ),
          backgroundColor: buttonColor),
    );
  }
}
