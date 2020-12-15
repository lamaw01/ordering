import 'dart:convert';
import 'package:ordering/models/cartModel.dart';
import 'package:http/http.dart' as http;

class CartService {
  static const VIEW_URL = 'http://192.168.0.12/ordering/view_cart.php';
  static const ADD_URL = 'http://192.168.0.12/ordering/add_cart.php';
  static const DELETE_URL = 'http://192.168.0.12/ordering/delete_cart.php';

  List<CartModel> cartFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<CartModel>.from(data.map((item) => CartModel.fromJson(item)));
  }

  Future<List<CartModel>> getCart() async {
    final response = await http.get(VIEW_URL);
    if (response.statusCode == 200) {
      List<CartModel> list = cartFromJson(response.body);
      return list;
    } else {
      return List<CartModel>();
    }
  }

  Future<String> addCart(CartModel cartModel) async {
    final response = await http.post(ADD_URL, body: cartModel.tojsonAdd());
    if (response.statusCode == 200) {
      print("Add response" + response.body);
      return response.body;
    } else {
      return "Error";
    }
  }

  Future<String> deleteCart(CartModel cartModel) async {
    try {
      final response =
          await http.post(DELETE_URL, body: cartModel.tojsonUpdate());
      if (response.statusCode == 200) {
        print("Delete response" + response.body);
        return response.body;
      } else {
        return "Error";
      }
    } catch (e) {
      return e.toString();
      // print(e.toString());
    }
  }
}
