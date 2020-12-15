import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ordering/models/checkoutModel.dart';

class CheckoutService {
  static const VIEW_URL = 'http://192.168.0.12/ordering/checkout_view.php';
  static const ADD_URL = 'http://192.168.0.12/ordering/checkout_add.php';

  List<CheckoutModel> checkoutFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<CheckoutModel>.from(
        data.map((item) => CheckoutModel.fromJson(item)));
  }

  Future<List<CheckoutModel>> getCheckout() async {
    final response = await http.get(VIEW_URL);
    if (response.statusCode == 200) {
      List<CheckoutModel> list = checkoutFromJson(response.body);
      return list;
    } else {
      return List<CheckoutModel>();
    }
  }

  Future<String> addCheckout(CheckoutModel checkoutModel) async {
    final response = await http.post(ADD_URL, body: checkoutModel.tojsonAdd());
    if (response.statusCode == 200) {
      print("Add response" + response.body);
      return response.body;
    } else {
      return "Error";
    }
  }
}
