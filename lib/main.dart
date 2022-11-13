import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String value = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Weather App"),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/sunny.jpeg"), fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                    future: apicall(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 30, 10),
                          child: Container(
                            child: Column(children: [
                              Text(snapshot.data['temp'].toString()),
                              Text(snapshot.data['description'].toString()),
                            ]),
                          ),
                        );
                      } else {
                        return CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation(
                              Color.fromARGB(255, 18, 46, 141)),
                          strokeWidth: 10,
                        );
                      }
                    })
              ],
            ),
          ),
        ));
  }
}

Future apicall() async {
  final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=bangalore&appid=980df60f9d48ff866d91fbde2a06bae1");
  // aka
  // final urli=Uri.parse("https://api.openweathermap.org",
  // path: "/data/2.5/weather",
  // queryParameters:{
  //   'q'='bangalore',
  //   'appid'='980df60f9d48ff866d91fbde2a06bae1'
  // });
  //
  final response = await http.get(url);
  print(response.body);
  final json = jsonDecode(response.body);
  print(json['weather'][0]['description']);
  final output = {
    'description': json['weather'][0]['description'],
    'temp': json['main']['temp']
  };
  return output;
}