import 'dart:convert';

import 'package:ordering/models/totalModel.dart';
import 'package:http/http.dart' as http;

class TotalValService {
  static const VIEW_URL = 'http://192.168.0.12/ordering/total.php';

  List<TotalValModel> userFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<TotalValModel>.from(
        data.map((item) => TotalValModel.fromJson(item)));
  }

  Future<List<TotalValModel>> getMenu() async {
    final response = await http.get(VIEW_URL);
    if (response.statusCode == 200) {
      List<TotalValModel> list = userFromJson(response.body);
      return list;
    } else {
      return List<TotalValModel>();
    }
  }
}
