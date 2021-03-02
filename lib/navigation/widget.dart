import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget createDrawerHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage("assets/images/bg_header.jpg"))),
      child: Stack(children: <Widget>[
        Positioned(bottom: 12.0, left: 16.0, child: Text("Test Application", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500))),
      ]));
}

Widget createDrawerBodyItem({IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}

class NavigationDrawer extends StatelessWidget {
  ListView DrawerList(context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        createDrawerHeader(),
        createDrawerBodyItem(
          icon: Icons.shopping_cart,
          text: 'My Cart',
          onTap: () => Navigator.of(context).pushNamed(PageRoutes.cart),
        ),
        createDrawerBodyItem(
          icon: Icons.logout,
          text: 'Logout',
          onTap: () => Navigator.of(context).pushReplacementNamed(PageRoutes.logout),
        ),
        ListTile(
          title: Text('App v1.0.1b'),
          onTap: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(child: DrawerList(context));
  }
}
