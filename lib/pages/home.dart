import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prova/data_storage/apirutes.dart';
import 'package:prova/pages/pagina_bus.dart';
import 'package:prova/pages/provaOnda.dart';
import 'package:prova/widget/containerbus.dart';
import 'package:prova/widget/menu.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  final AuthResult user;
  Home({Key key, this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<List<APIRoute>> buses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        backgroundColor: hexToColor("#0058A5"),
        title: Row(
          children: <Widget>[
            Text(
              'SocialBus',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          color: Colors.grey[200],
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                25,
                0,
                0,
              ),
              //builder di "container_bus da flie json"
              child: FutureBuilder(
                future: loadRoutes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return new GridView.builder(
                      itemCount: buses.length,
                      itemBuilder: (BuildContext context, int index) {
                        final List<APIRoute> routes = buses[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaginaBus(
                                      user: widget.user, bus: routes)),
                            );
                          },
                          child: new ContainerBus(
                            nomeBus: routes[0].routeShortName,
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 5.0,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return new Text("${snapshot.error}");
                  }
                  return new SpinKitWanderingCubes(
                    color: hexToColor("#0058A5"),
                    size: 50.0,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

//routes asset Json file
  Future<String> _loadRutesAsset() async {
    return await rootBundle.loadString('assets/json/routes.json');
  }

//jsons file to list of ApiRoutes
  Future<List<APIRoute>> loadRoutes() async {
    wait(30);
    buses = [];
    String jsonString = await _loadRutesAsset();
    final Iterable jsonResponse = json.decode(jsonString);
    List<APIRoute> routes = [];
    routes = jsonResponse.map((route) => APIRoute.fromJson(route)).toList();
    List<APIRoute> busList = [];
    for (int i = 0; i < routes.length - 1; i++) {
      busList.add(routes[i]);
      if (routes[i].routeShortName != routes[i + 1].routeShortName) {
        busSorting(busList);
        busList = [];
      }
    }
    return routes;
  }

  void busSorting(List<APIRoute> busList) {
    buses.add(busList);
  }

  Future wait(int seconds) {
    return new Future.delayed(Duration(seconds: seconds), () => {});
  }
}
