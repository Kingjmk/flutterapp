import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/generic.dart';
import 'package:app/pages/pages.dart';
import 'package:app/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndexPage extends StatefulWidget {
  static const String routeName = '/';
  const IndexPage({Key key}) : super(key: key);

  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  var authBloc;

  void redirect() async {
    String routeName = PageRoutes.login;
    if (authBloc.state is AuthenticationAuthenticated){
      routeName = PageRoutes.itemsList;
    }
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    this.authBloc = BlocProvider.of<AuthenticationBloc>(context);
    this.redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Loader(child: Text('Loading...')),
    );
  }
}
