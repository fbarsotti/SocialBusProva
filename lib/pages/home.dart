import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prova/data/api_route.dart';
import 'package:prova/pages/provaOnda.dart';
import 'package:prova/widget/app_drawer.dart';

class Home extends StatefulWidget {
  final AuthResult user;
  Home({Key key, this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<List<APIRoute>> buses = [];

  List<APIRoute> routes = List();
  List<APIRoute> filteredRoutes = List();

  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text("Social bus");

  String _searchText = "";

  final TextEditingController _filter = TextEditingController();

  _HomeState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredRoutes = routes;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0.0,
        title: _appBarTitle,
        actions: <Widget>[
          IconButton(
            icon: _searchIcon,
            onPressed: () {
              _searchPressed();
            },
          )
        ],
      ),
      // appBar: AppBar(
      //   backgroundColor: ,
      //   title: Text(
      //     'Social Bus',
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: _searchIcon,
      //       onPressed: () {
      //         _searchPressed();
      //       },
      //     )
      //   ],
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Center(
          child: Container(
            child: FutureBuilder(
              future: loadRoutes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<APIRoute> routes = snapshot.data;
                  if (_searchText.isNotEmpty) {
                    routes = routes
                        .where((r) => r.routeShortName
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()))
                        .toList();
                  }

                  return ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: routes.length,
                      itemBuilder: (BuildContext context, int index) {
                        final APIRoute route = routes[index];

                        return Card(
                          child: Container(
                            child: ListTile(
                              title: Text('${route.routeShortName}'),
                              subtitle: Text(route.routeLongName),
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  print('ERROR');
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
    );
  }

//routes asset Json file
  Future<String> _loadRutesAsset() async {
    return await rootBundle.loadString('assets/json/routes.json');
  }

//jsons file to list of ApiRoutes
  Future<List<APIRoute>> loadRoutes() async {
    buses = [];
    String jsonString = await _loadRutesAsset();

    Iterable l = json.decode(jsonString);
    List<APIRoute> routes = l.map((model) => APIRoute.fromJson(model)).toList();

    // final Iterable jsonResponse = json.decode(jsonString);
    // List<APIRoute> routes = [];
    // routes = jsonResponse.map((route) => APIRoute.fromJson(route)).toList();

    return routes;
  }

  void busSorting(List<APIRoute> busList) {
    buses.add(busList);
  }

  Future wait(int seconds) {
    return new Future.delayed(Duration(seconds: seconds), () => {});
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          controller: _filter,
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Cerca",
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text('Social bus');
        //filteredNames = names;
        _filter.clear();
      }
    });
  }
}
