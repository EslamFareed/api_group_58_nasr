import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map> products = [];

  _getData() async {
    try {
      var response =
          await Dio().get("https://api.escuelajs.co/api/v1/products");

      if (response.statusCode == 200) {
        var data = response.data as List; // json to list
        for (var element in data) {
          // list => List<Map>
          products.add(element);
        }
        setState(() {});
        print(products.length);
      } else {
        print("${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              products.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(products[index]["title"]),
                            subtitle: Text(products[index]["price"].toString()),
                          ),
                        );
                      },
                      itemCount: products.length,
                    ),
              ElevatedButton(
                onPressed: () async {
                  // get
                  // link : https://api.escuelajs.co/api/v1/products
                  // response : success = 200 , fail != 200
                  // data : List<Map>

                  try {
                    var response = await Dio()
                        .get("https://api.escuelajs.co/api/v1/products");

                    if (response.statusCode == 200) {
                      var data = response.data as List; // json to list
                      for (var element in data) {
                        // list => List<Map>
                        products.add(element);
                      }
                      print(products.length);
                    } else {
                      print("${response.statusCode}");
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: const Text("Get Products"),
              ),
              ElevatedButton(
                onPressed: () async {
                  String email = "john@mail.com"; // Coming from text field
                  String password =
                      "changeme"; // Coming from another text field

                  try {
                    var response = await Dio()
                        .post("https://api.escuelajs.co/api/v1/auth/login",
                            // data: FormData.fromMap({}) // Form data
                            data: {
                          "email": email,
                          "password": password,
                        } // Raw data
                            // queryParameters:
                            );
                    if (response.statusCode == 201) {
                      print(response.data["access_token"]);
                    } else {
                      print("Login error");
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: const Text("Login"),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    var response = await Dio().post(
                      "https://api.escuelajs.co/api/v1/users/",
                      data: {
                        "name": "Eslam",
                        "email": "eslam@gmail.com",
                        "password": "123456",
                        "avatar": "https://picsum.photos/800",
                      },
                    );
                    if (response.statusCode == 201) {}
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: const Text("Create new user"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Get single product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
