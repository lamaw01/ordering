class CartModel {
  String cartid;
  String menuid;
  String menuname;
  String menuprice;

  CartModel({this.cartid, this.menuid, this.menuname, this.menuprice});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartid: json['cartid'] as String,
      menuid: json['menuid'] as String,
      menuname: json['menuname'] as String,
      menuprice: json['menuprice'] as String,
    );
  }

  Map<String, dynamic> tojsonAdd() {
    return {
      // "cartid": cartid,
      "menuid": menuid,
      "menuname": menuname,
      "menuprice": menuprice,
    };
  }

  Map<String, dynamic> tojsonUpdate() {
    return {
      "cartid": cartid,
      "menuid": menuid,
      "menuname": menuname,
      "menuprice": menuprice,
    };
  }
}
