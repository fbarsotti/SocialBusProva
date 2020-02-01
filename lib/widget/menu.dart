import 'package:flutter/material.dart';
import 'package:prova/pages/provaOnda.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String urlTime = 'http://actv.avmspa.it/it/content/rete-venezia-unica-0';
    String urlMoney = 'http://actv.avmspa.it/it/content/prezzi-vigore-0';
    String urlWrite = '';
    String urlRead = 'http://actv.avmspa.it/it/content/rete-venezia-unica-0';
    String urlCom = 'http://actv.avmspa.it/it/content/rete-venezia-unica-0';
    String urlSito = 'http://actv.avmspa.it/it/content/rete-venezia-unica-0';

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(
              color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(color: hexToColor("#0058A5")),
          ),
          ListTile(
            title: Text('Leggi'),
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProvaOnda()),
                );
              },
          ),
          ListTile(
            title: Text('Scrivi'),
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProvaOnda()),
                );
              },
          ),
                   ListTile(
            title: Text('Orari'),
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProvaOnda()),
                );
              },
          ),
                    ListTile(
            title: Text('Comunicazioni'),
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProvaOnda()),
                );
              },
          ),
                    ListTile(
            title: Text('Sito'),
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProvaOnda()),
                );
              },
          ),
        ],
      ),
    );
  }
}
