import 'dart:convert';
import 'dart:io';
//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_12/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
//import 'package:alt_http/alt_http.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token");
    // Map<String, String> headers = {
    //   //HttpHeaders.acceptHeader: "*/*",
    //   //HttpHeaders.contentTypeHeader: "application/json",
    //   "Authorization": "Bearer $token",
    // };

    // http.post(url, headers: headers).then((http.Response response) {
    //   print(response.body);
    //   print(response.request.headers);
    //});
    try {
      var url = 'https://app.iwopay.net/me';
      print('Token $token');
      final response = await http.post(
        url,
        headers: {
          'Accept': '*/*',
          //'Content-type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token'
        },
      );
      final body = json.decode(response.body);
      print("Result: ${response.headers}");
      //print(response.statusCode);
      print(body);
      if (response.statusCode == 200) {
        var email = body['email'];
        var id = body['id'];

        try {
          print(body);
          print('id $id');
          print('email $email');
        } catch (e) {
          print(e);
        }
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LoginDemo(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      print('isi $e');
    }
  }

  @override
  void initState() {
    _getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      body: Center(
        child: Container(
          height: 80,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          child: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Welcome',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
