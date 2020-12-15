class MenuModel {
  String menuid;
  String menuname;
  String menudescription;
  String menuprice;
  String menuimg;

  MenuModel(
      {this.menuid,
      this.menuname,
      this.menudescription,
      this.menuprice,
      this.menuimg});

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      menuid: json['menuid'] as String,
      menuname: json['menuname'] as String,
      menudescription: json['menudescription'] as String,
      menuprice: json['menuprice'] as String,
      menuimg: json['menuimg'] as String,
    );
  }
}
