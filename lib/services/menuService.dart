import 'dart:convert';

import 'package:ordering/models/menuModel.dart';
import 'package:http/http.dart' as http;

class MenuService {
  static const VIEW_URL = 'http://192.168.0.12/ordering/view.php';

  List<MenuModel> userFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<MenuModel>.from(data.map((item) => MenuModel.fromJson(item)));
  }

  Future<List<MenuModel>> getMenu() async {
    final response = await http.get(VIEW_URL);
    if (response.statusCode == 200) {
      List<MenuModel> list = userFromJson(response.body);
      return list;
    } else {
      return List<MenuModel>();
    }
  }
}
