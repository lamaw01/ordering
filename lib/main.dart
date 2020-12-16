import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'colors.dart';
import 'package:ordering/menu.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    try {
      var url = "http://192.168.0.12/ordering/login.php";
      var response = await http.post(url, body: {
        "username": user.text,
        "password": pass.text,
      });
      var data = json.decode(response.body);
      if (data == "Success") {
        Toast.show(
          'Login Successful',
          context,
          gravity: Toast.BOTTOM,
          duration: 2,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Menu(),
          ),
        );
      } else {
        Toast.show(
          'Username and password invalid',
          context,
          gravity: Toast.BOTTOM,
          duration: 2,
        );
      }
    } catch (e) {
      print(e.toString());
      Toast.show(
        e.toString(),
        context,
        gravity: Toast.BOTTOM,
        duration: 2,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Card(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                controller: user,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                controller: pass,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        color: buttonColor,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        onPressed: () {
                          if (user.text.isEmpty || pass.text.isEmpty) {
                            Toast.show(
                              "All field is required",
                              context,
                              gravity: Toast.BOTTOM,
                              duration: 2,
                            );
                          } else {
                            login();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
