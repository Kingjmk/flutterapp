import 'package:app/pages/items/detail.dart';
import 'package:app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PageRoutes {
  static const String index = IndexPage.routeName;
  static const String login = LoginPage.routeName;
  static const String logout = LogoutPage.routeName;
  static const String itemsList = ItemsListPage.routeName;
  static const String itemsDetail = ItemsDetailPage.routeName;
}

getRoutes(BuildContext context) {
  var routes = {
    PageRoutes.index: (context) => IndexPage(),
    PageRoutes.login: (context) => LoginPage(),
    PageRoutes.logout: (context) => LogoutPage(),
    PageRoutes.itemsList: (context) => ItemsListPage(),
    PageRoutes.itemsDetail: (context) => ItemsDetailPage(),
  };

  return routes;
}

// TODO: fix this function and implement it
onGenerateRoute(settings) {
  switch (settings.name) {
    case PageRoutes.itemsDetail:
      return PageTransition(
        child: ItemsDetailPage(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
      break;
    default:
      return null;
  }
}
