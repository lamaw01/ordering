class TotalValModel {
  String total;

  TotalValModel({this.total});

  factory TotalValModel.fromJson(Map<String, dynamic> json) {
    return TotalValModel(
      total: json['total'] as String,
    );
  }
}
