import 'package:flutter/material.dart';
import 'package:ordering/models/menuModel.dart';
import 'package:ordering/services/menuService.dart';

class Menu extends StatefulWidget {
  Menu() : super();
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<MenuModel> menuList;
  bool loading = true;

  getAllMenu() async {
    menuList = await MenuService().getMenu();
    setState(() {
      loading = false;
    });
    print("user : ${menuList.length}");
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
        title: Text('Messages'),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: menuList.length,
              itemBuilder: (context, index) {
                MenuModel menu = menuList[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                    child: ListTile(
                      leading: Container(
                        width: 80,
                        height: 80,
                        child: Image.network(imageUrl + menu.menuimg),
                      ),
                      title: Text(
                        menu.menuname,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        menu.menudescription,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      trailing: Text(menu.menuprice),
                      onTap: () {},
                    ),
                  ),
                );
              }),
    );
  }
}
