class CheckoutModel {
  String orderid;
  String summary;

  CheckoutModel({this.orderid, this.summary});

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      orderid: json['orderid'] as String,
      summary: json['summary'] as String,
    );
  }
  Map<String, dynamic> tojsonAdd() {
    return {
      // "orderid": orderid,
      "summary": summary,
    };
  }
}
