import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/blocs/blocs.dart';
import 'package:app/generic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutPage extends StatefulWidget {
  static const String routeName = 'logout';
  const LogoutPage({Key key}) : super(key: key);

  LogoutPageState createState() => LogoutPageState();
}

class LogoutPageState extends State<LogoutPage> {

  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      authBloc.add(UserLoggedOut());
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Loader(child: Text('Logging out...')),
    );
  }
}
